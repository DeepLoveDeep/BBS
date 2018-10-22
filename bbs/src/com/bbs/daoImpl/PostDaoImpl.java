package com.bbs.daoImpl;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.bbs.model.SubForum;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bbs.dao.PostDao;
import com.bbs.model.Followcard;
import com.bbs.model.Post;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * @author Shen
 * @version 1.0
 *          2018年6月17日下午8:22:52
 */
public class PostDaoImpl extends HibernateDaoSupport implements PostDao {

    private static final Logger log = LoggerFactory.getLogger(PostDaoImpl.class);
    // property constants
    public static final String TITLE = "title";
    public static final String CARD_CONTENT = "cardContent";
    public static final String POST_TYPE = "postType";
    public static final String REPLY_NUM = "replyNum";


//	public void save(Post transientInstance) {
//		log.debug("saving Post instance");
//		try {
//			Session session = getSession();
//			session.save(transientInstance);
//			
//			log.debug("save successful");
//		} catch (RuntimeException re) {
//			log.error("save failed", re);
//			throw re;
//		}
//	}


    public Post findById(java.lang.Integer id) {
        log.debug("getting Post instance with id: " + id);
        try {
            Session session = getSessionFactory().openSession();
            Post instance = (Post) session.get("com.bbs.model.Post", id);
            session.flush();
            session.close();
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }


    public List findByProperty(String propertyName, Object value) {
        log.debug("finding Post instance with property: " + propertyName
                + ", value: " + value);
        try {
            String queryString = "from Post as model where model."
                    + propertyName + "= ?";
            Session session = getSessionFactory().openSession();
            Query queryObject = session.createQuery(queryString);
            queryObject.setParameter(0, value);
            List list = queryObject.list();
            session.flush();
            session.close();
            return list;
        } catch (RuntimeException re) {
            log.error("find by property name failed", re);
            throw re;
        }
    }

    public List findByTitle(Object title) {
        return findByProperty(TITLE, title);
    }

    public List findByCardContent(Object cardContent) {
        return findByProperty(CARD_CONTENT, cardContent);
    }

    public List findByPostType(Object postType) {
        return findByProperty(POST_TYPE, postType);
    }

    public List findByReplyNum(Object replyNum) {
        return findByProperty(REPLY_NUM, replyNum);
    }


    @Override
    public void pushlish(Post post) throws IOException {
        String content=post.getCardContent();
       /* // 使用默认单例（加载默认词典）
        SensitiveFilter filter = SensitiveFilter.DEFAULT;*/
        Properties prop = new Properties();
        InputStream ins = this.getClass().getResourceAsStream("/resource/properties.properties");
        prop.load(ins);
        String keyPath = prop.getProperty("KEYURL");
        BufferedReader br = new BufferedReader( new InputStreamReader(new FileInputStream(keyPath), "UTF-8"));
        ArrayList<String> array = new ArrayList<String>();
        String line = null;
        while ((line = br.readLine()) != null) {
            array.add(line);
        }
        // 释放资源
        br.close();
        // 进行过滤
        // 遍历集合
        for (String s : array) {
            //是否包含敏感字符
            if(content.contains(s)){
                //将敏感字符替换成指定字符
               //content.replaceAll(s,"*");
               post.setIf_pass(0);
           }
        }
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.save(post);
        transaction.commit();
        session.flush();
        session.close();
    }


    @Override
    public List<Followcard> getFollowCards(int postId, int pageIndex, int pageSize) {
        Session session = getSessionFactory().openSession();
        String sql = "from Followcard follow where follow.post.id=? and follow.if_delete=1 order by follow.followDate desc ";
        Query query = session.createQuery(sql);
        query.setInteger(0, postId);
        int startIndex = (pageIndex - 1) * pageSize;
        query.setFirstResult(startIndex);
        query.setMaxResults(pageSize);
        List list = query.list();
        session.flush();
        session.close();
        return list;
    }


    @Override
    public Post getPostById(int postId) {
        Session session = getSessionFactory().openSession();
        String sql = "from Post p where p.id=?  and p.if_delete=1";
        Query query = session.createQuery(sql);
        query.setInteger(0, postId);
        List<Post> posts = query.list();
        session.flush();
        session.close();
        if (posts != null && posts.size() > 0)
            return posts.get(0);
        return null;
    }
    /**
     * 上一篇from Blog b where b.bid<? order by b.bid desc
     * */
    @Override
    public Post getUpPostById(int postId) {
        //根据帖子id找到分类id
        Post post =getPostById(postId);
        SubForum subForum = post.getSubForum();
        Integer id = subForum.getMainForum().getId();
        Session session = getSessionFactory().openSession();
        String sql = "from Post p where p.if_delete=1 and p.subForum.mainForum.id=? and p.id > ?  order by p.id desc ";
        Query query = session.createQuery(sql);
        query.setInteger(0,id);
        query.setInteger(1, postId);
        List<Post> posts = query.list();
        session.flush();
        session.close();
        if (posts != null && posts.size() > 0)
            return posts.get(0);
        return null;
    }
    /**
     * 下一篇
     * */
    @Override
    public Post getNextPostById(int postId) {
        //根据帖子id找到分类id
        Post post =getPostById(postId);
        SubForum subForum = post.getSubForum();
        Integer id = subForum.getMainForum().getId();
        Session session = getSessionFactory().openSession();
        String sql = "from Post p where p.if_delete=1 and p.subForum.mainForum.id=? and p.id <?  order by p.id desc";
        Query query = session.createQuery(sql);
        query.setInteger(0, id);
        query.setInteger(1, postId);
        List<Post> posts = query.list();
        session.flush();
        session.close();
        if (posts != null && posts.size() > 0)
            return posts.get(0);
        return null;
    }
    public List<Post> search(String keyword) {

        Session session = getSessionFactory().openSession();
        String sql = "from Post p where p.title like ? and p.if_pass=1 and p.if_delete=1";
        Query query = session.createQuery(sql);
        query.setString(0, '%' + keyword + '%');
        List list = query.list();
        session.flush();
        session.close();
        return list;
//		Session session = getSession();
//		Criteria criteria = session.createCriteria(Post.class);
//		criteria.add(Restrictions.like("title",keyword,MatchMode.ANYWHERE));
//		List list = criteria.list();
//		session.close();
//		return list;
    }

    @Override
    public List<Post> getLatestPosts(int pageIndex, int pageSize) {
        Session session = getSessionFactory().openSession();
        String sql = "from Post p where p.if_pass=1 and p.if_delete=1 order by p.sendDate desc";
        Query query = session.createQuery(sql);
        int startIndex = (pageIndex - 1) * pageSize;
        query.setFirstResult(startIndex);
        query.setMaxResults(pageSize);
        List list = query.list();
        session.flush();
        session.close();
        return list;
    }
    //获取异常帖7
    @Override
    public List<Post> getLatestPosts2(int pageIndex, int pageSize) {
        Session session = getSessionFactory().openSession();
        String sql = "from Post p where p.if_pass!=1 and p.if_delete=1 order by p.sendDate desc";
        Query query = session.createQuery(sql);
        int startIndex = (pageIndex - 1) * pageSize;
        query.setFirstResult(startIndex);
        query.setMaxResults(pageSize);
        List list = query.list();
        session.flush();
        session.close();
        return list;
    }

    @Override
    public List<Post> getHotPosts(int pageIndex, int pageSize) {
        Session session = getSessionFactory().openSession();
        String sql = "from Post p where p.if_pass=1 and p.if_delete=1 order by p.viewNum desc";
        Query query = session.createQuery(sql);
        int startIndex = (pageIndex - 1) * pageSize;
        query.setFirstResult(startIndex);
        query.setMaxResults(pageSize);
        List list = query.list();
        session.flush();
        session.close();
        return list;
    }
    /**
     *
     * 根据用户名获取用户的消息总数
     * */
    @Override
    public Object getNumByUsername(int userid) {

        try {
        Session session = getSessionFactory().openSession();
        String sql = "SELECT SUM(p.replyNum) FROM Post p where p.user.id=? and p.if_delete=1 ";
        Query query = session.createQuery(sql);
        query.setParameter(0, userid);
        Object num = query.uniqueResult();
        session.flush();
        session.close();
        return num ;
        } catch (RuntimeException re) {
            log.error("find by property name failed", re);
            throw re;
        }
    }

    @Override
    public List<Post> getBestPosts(int pageIndex, int pageSize) {
        Session session = getSessionFactory().openSession();
        String sql = "from Post p where p.postType = 1 and p.if_pass=1 and p.if_delete=1  order by p.sendDate desc ";
        Query query = session.createQuery(sql);
        int startIndex = (pageIndex - 1) * pageSize;
        query.setFirstResult(startIndex);
        query.setMaxResults(pageSize);
        List list = query.list();
        session.flush();
        session.close();
        return list;
    }

    public List<Post> getPostByType(int type, int pageIndex, int pageSize) {
        if (type > 0) {
            Session session = getSessionFactory().openSession();
            String sql = "from Post p where p.subForum.mainForum.id=? and p.if_pass=1 and p.if_delete=1 order by p.sendDate desc ";
            Query query = session.createQuery(sql);
            query.setInteger(0, type);
            int startIndex = (pageIndex - 1) * pageSize;
            query.setFirstResult(startIndex);
            query.setMaxResults(pageSize);
            List list = query.list();
            session.flush();
            session.close();
            return list;
        } else if (type == -1) {
            return getLatestPosts(pageIndex, pageSize);
        } else if (type == -2) {
            return getBestPosts(pageIndex, pageSize);
        } else if (type == -3) {
            return getHotPosts(pageIndex, pageSize);
        }
        return null;

    }


    @Override
    public List<Post> getPostByUserId(int userId, int pageIndex, int pageSize) {
        Session session = getSessionFactory().openSession();
        String sql = "from Post p where p.user.id = ? and p.if_delete=1 order by p.sendDate desc";
        Query query = session.createQuery(sql);
        query.setInteger(0, userId);
        int startIndex = (pageIndex - 1) * pageSize;
        query.setFirstResult(startIndex);
        query.setMaxResults(pageSize);
        List list = query.list();
        session.flush();
        session.close();
        return list;
    }

    //发表评论，帖子评论数加一
    @Override
    public void autoIncreaseReply(int postId) {
        Post post = findById(postId);
        post.setReplyNum(post.getReplyNum() + 1);
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(post);
        transaction.commit();
        session.flush();
        session.clear();
        session.close();
    }
    //删除评论，帖子评论数减一
    @Override
    public void delIncreaseReply(int postId) {
        Post post = findById(postId);
        post.setReplyNum(post.getReplyNum() - 1);
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(post);
        transaction.commit();
        session.flush();
        session.clear();
        session.close();
    }

    public void delete(int postId) {
        Post post = findById(postId);
        post.setIf_delete(0);
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(post);
        transaction.commit();
        session.flush();
        session.close();
    }

    @Override
    public void updateType(Integer postId) {
        Post post = findById(postId);
        post.setPostType(1);
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(post);
        transaction.commit();
        session.flush();
        session.close();
    }

    //帖子审核通过
    @Override
    public void updatePass(Integer postId) {
        Post post = findById(postId);
        post.setIf_pass(1);
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(post);
        transaction.commit();
        session.flush();
        session.close();
    }

    //帖子被驳回
    @Override
    public void updateNoPass(Integer postId) {
        Post post = findById(postId);
        post.setIf_pass(2);
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(post);
        transaction.commit();
        session.flush();
        session.close();
    }


    @Override
    public void updatePost(Post post) {
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(post);
        transaction.commit();
        session.close();

    }

    @Override
    public void autoIncreaseViewNum(int postId) {
        Post post = findById(postId);
        post.setViewNum(post.getViewNum() + 1);
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(post);
        transaction.commit();
        session.flush();
        session.clear();
        session.close();
    }

    /**
     * 点赞
     * */
    @Override
    public void greatNum(Integer id,Integer greatNum) {
        Post post = findById(id);
        post.setGreatNum(greatNum);
        Session session = getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(post);
        transaction.commit();
        session.flush();
        session.close();
    }

}

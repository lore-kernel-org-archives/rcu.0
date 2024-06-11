Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B471CFA9
	for <rcu@vger.kernel.org>; Tue, 11 Jun 2024 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124055; cv=none; b=QckIJLJsSIs6AwwvbOGFE7VZyHyyD0zzkYPQXwOKEt2jXkECDRSumnMmyz/Yi6oJVQPUTKo5mbDPEP74j5e/kenjF2pMcV4aDkwa1simg93EFoMhLG4iUMTzh4kiLP0ANBj9lkmeXkbCtG6zIyBY2UanBnWu4oBW8vCTS1g+Dd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124055; c=relaxed/simple;
	bh=Srk3NNOGwmHwXXua8ug1Y4oXlU6QvZ9RM0g864ujU7w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyXlz4u9HOJsd1AC75ijSsdUWUW0v6ivVrWqL0nz8Lugqna0p1Z8QgurM7dm/XBXDa4+zm96jziqDg1n2DUoPXx1CmH5AMRMwflWNdp0s+FlWHew1wmmefX1BZalzgY77H1XPkoSq34vA019Yid9MB/3aG+6nk8joBRwU3zkfh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJZaCAAr; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJZaCAAr"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso24657541fa.0
        for <rcu@vger.kernel.org>; Tue, 11 Jun 2024 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718124052; x=1718728852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3cp5cBt94hqMuZOiuslwcsypWMUhnJVnOEPMjj6Pe0=;
        b=EJZaCAArw5A+Aenf1lNkSGk+BraEng5IMiR9GdMQPyThKNxWsHfQuquO7s7RigBQ20
         fawfvo+od6AMDMt3TypkOgayqYs3e1Y4hKkmuU4F8pO5iyF3EumADxNc1gEv6V4hOqm7
         FadrefXTP4p7nZMWHDgDipina8XqBd2Jo2FyJYO4G/OStOTIO2a6qdGoZPx+KI307xIA
         1IsQ+MjZti93bXtxHegJj/9sL5TZwtHCB3KEm5x5pvN433vuPvLMuq7Se5W3WyN3lV/e
         gw5WHfbkhALMB8/B+2LxfG1HJeu7ncwtWZiMnyTTUlvFpkL9KLJTgvJF2UIP41Q1h97V
         1Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718124052; x=1718728852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3cp5cBt94hqMuZOiuslwcsypWMUhnJVnOEPMjj6Pe0=;
        b=itadPo5C2Ut6rILO1rySbI5aN6mW3BoujwxppXK8X+mwCnqB8ps1RSMNL/aMs5ZxEr
         DOJOI7r91LImk5b7291W4SJNWTTG77XUB4BjMgUaS9NaJeSM4BxD4/fJiP2NfdMVDCXJ
         x/kRIZaPTUzLnCb7efGcLlcqR2/ffrHn30vTFNhrhAWKZYPnC4zj7KFdMuQ4kKC99yim
         7hwuuVwCLpqVu8qqkmjXHGKPkElErGARYwMgNHtJVYrXAtVD4RFCHKRK+gL9AHGkUg/d
         0JdC5CPF1HLVxnnTGSwJQtF8aHSYHEBf9/hhIfTh6kw1Z1BLXJfcVEZhCr0fUMb0Yb/W
         aAFw==
X-Forwarded-Encrypted: i=1; AJvYcCXQyIyEbEoCFhiqWzI2niTu8qiYMYJhyPy3UBINx9OA/F1izq8DZR4oW9jMuIC4aaxxMfS1qcpVdeMG4MHmxpK+0d1i
X-Gm-Message-State: AOJu0YwdbnGPagRhjlntAri0YhsjijwBN63FBVq7ga7b106xfC39qKVw
	Bt1ZVvdO08VEuK0iYS2wT/TIvzPG2VogxGHw5vZX92YgZn0vNesL
X-Google-Smtp-Source: AGHT+IEbo3JpmZ5Ejf1Kjt4blYqXT4/XXSYFYE0gsw6Uo+iMJTP8Yyob5KSxpkPUQlraHuzFQ3p+Iw==
X-Received: by 2002:a2e:9588:0:b0:2eb:d798:ba7c with SMTP id 38308e7fff4ca-2ebd798bc40mr54670691fa.52.1718124051308;
        Tue, 11 Jun 2024 09:40:51 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7ef8d914sm4589340a12.71.2024.06.11.09.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:40:50 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Tue, 11 Jun 2024 18:40:49 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: Julia Lawall <julia.lawall@inria.fr>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	RCU <rcu@vger.kernel.org>, cocci@inria.fr
Subject: Re: [cocci] patch idea: convert trivial call_rcu users to kfree_rcu
Message-ID: <Zmh-EYvXqL3JBt1p@pc638.lan>
References: <a1f15e67-25f5-4a0b-a9d0-ebbc0555fb12@paulmck-laptop>
 <alpine.DEB.2.22.394.2405272226510.3330@hadrien>
 <ZlXIDZLMNPc7E7XE@pc636>
 <2dd5bafb-ceb1-238d-2f51-83ebf135b73@inria.fr>
 <ZlXaPuA4lC2ANTdN@pc636>
 <2ec7eb0f-0950-4d65-b33a-64df7c5f89c9@paulmck-laptop>
 <77531e55-3418-d4be-f538-7ddc904ed88f@inria.fr>
 <Zl76AZ_0H5xb1cFl@pc638.lan>
 <alpine.DEB.2.22.394.2406091158420.3474@hadrien>
 <21a32cbb-d388-4a8c-9298-ef8c82330f9e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21a32cbb-d388-4a8c-9298-ef8c82330f9e@paulmck-laptop>

> > 
> > These look ok to me.  In the last two cases, the callback function is also
> > stored in a data structure, eg:
> > 
> > static struct mfc6_cache *ip6mr_cache_alloc(void)
> > {
> > 	struct mfc6_cache *c = kmem_cache_zalloc(mrt_cachep, GFP_KERNEL);
> > 	if (!c)
> > 		return NULL;
> > 	c->_c.mfc_un.res.last_assert = jiffies - MFC_ASSERT_THRESH - 1;
> > 	c->_c.mfc_un.res.minvif = MAXMIFS;
> > 	c->_c.free = ip6mr_cache_free_rcu;
> > 	refcount_set(&c->_c.mfc_un.res.refcount, 1);
> > 	return c;
> > }
> > 
> > Should that be left as it is?
> 
> Given that ->_c.free isn't used in the RCU callback, I am guessing that
> this is intended for debugging purposes, so that you can see from a crash
> dump how this will be freed.  But I could be completely off-base here.
> 
> One approach would be to remove the ->_c.free field and call attention
> to this in the patches' commit logs.
> 
> Another would be to instead put the address of the allocation function
> in ->_c.free, and again call attention to this in the commit logs.
> 
> Is there a better approach than these three?  ;-)
> 
IMO, "_c.free" should be removed:

diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index 9dd4bf157255..45f220f761df 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -130,7 +130,6 @@ enum {
  * @refcount: reference count for this entry
  * @list: global entry list
  * @rcu: used for entry destruction
- * @free: Operation used for freeing an entry under RCU
  */
 struct mr_mfc {
 	struct rhlist_head mnode;
@@ -156,13 +155,12 @@ struct mr_mfc {
 	} mfc_un;
 	struct list_head list;
 	struct rcu_head	rcu;
-	void (*free)(struct rcu_head *head);
 };
 
 static inline void mr_cache_put(struct mr_mfc *c)
 {
 	if (refcount_dec_and_test(&c->mfc_un.res.refcount))
-		call_rcu(&c->rcu, c->free);
+		kfree_rcu(c, rcu);
 }
 
 static inline void mr_cache_hold(struct mr_mfc *c)
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 6c750bd13dd8..5d2e339f09cc 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -702,16 +702,9 @@ static int vif_delete(struct mr_table *mrt, int vifi, int notify,
 	return 0;
 }
 
-static void ipmr_cache_free_rcu(struct rcu_head *head)
-{
-	struct mr_mfc *c = container_of(head, struct mr_mfc, rcu);
-
-	kmem_cache_free(mrt_cachep, (struct mfc_cache *)c);
-}
-
 static void ipmr_cache_free(struct mfc_cache *c)
 {
-	call_rcu(&c->_c.rcu, ipmr_cache_free_rcu);
+	kfree_rcu(c, _c.rcu);
 }
 
 /* Destroy an unresolved cache entry, killing queued skbs
@@ -959,7 +952,6 @@ static struct mfc_cache *ipmr_cache_alloc(void)
 	if (c) {
 		c->_c.mfc_un.res.last_assert = jiffies - MFC_ASSERT_THRESH - 1;
 		c->_c.mfc_un.res.minvif = MAXVIFS;
-		c->_c.free = ipmr_cache_free_rcu;
 		refcount_set(&c->_c.mfc_un.res.refcount, 1);
 	}
 	return c;
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index dd342e6ecf3f..1634fa794ea2 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -753,16 +753,9 @@ static int mif6_delete(struct mr_table *mrt, int vifi, int notify,
 	return 0;
 }
 
-static inline void ip6mr_cache_free_rcu(struct rcu_head *head)
-{
-	struct mr_mfc *c = container_of(head, struct mr_mfc, rcu);
-
-	kmem_cache_free(mrt_cachep, (struct mfc6_cache *)c);
-}
-
 static inline void ip6mr_cache_free(struct mfc6_cache *c)
 {
-	call_rcu(&c->_c.rcu, ip6mr_cache_free_rcu);
+	kfree_rcu(c, _c.rcu);
 }
 
 /* Destroy an unresolved cache entry, killing queued skbs
@@ -985,7 +978,6 @@ static struct mfc6_cache *ip6mr_cache_alloc(void)
 		return NULL;
 	c->_c.mfc_un.res.last_assert = jiffies - MFC_ASSERT_THRESH - 1;
 	c->_c.mfc_un.res.minvif = MAXMIFS;
-	c->_c.free = ip6mr_cache_free_rcu;
 	refcount_set(&c->_c.mfc_un.res.refcount, 1);
 	return c;
 }

--
Uladzislau Rezki

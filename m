Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C45C269894;
	Tue, 25 Feb 2025 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490765; cv=none; b=cDBw2LAxlKg5hF2pgMGRBQQvpJBx3voFC9Gpb72Q1rrpwN/i09/vS7aLOep7Pnx6Njmg3vVdBroi2cznB8KwC7TTeiCw66/6Irnxcfx614xUGTG2TxYrorlh4hMg761jG4ubsQST+XxvRP5IOcK7R7jgTBF3qOD0PavYZIzMX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490765; c=relaxed/simple;
	bh=dUEd53I8m8JbwAxLH4WKR8fqprgXjlhyTwI5+nJa7/8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4gjJEz7Z5qrdR/S/9J2e2rNsUzdbJH8ZOJF7tbuCZA6YSzcCXF1Zn+dXFzKD3UIXoBykXRcNhLJQsBveohnSvvi/VpNCooM/pxNsWjyFESOV6X7SsQk9dgUYfI3dWRwSLlyLkWDPzX985G2zRFnlQ7WBOhVPl4+Tf7h6Sn4D/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaeNCm5Q; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaeNCm5Q"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30a2f240156so57585601fa.3;
        Tue, 25 Feb 2025 05:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740490761; x=1741095561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uT3CYG520Dq/1dijGlLbTlImqbVeMFyUskqf9mGklcY=;
        b=VaeNCm5QAKhSb9Yqtv6qH3dA4QHqXwGJhTwUHe6/Abx8p8daUTHLQUlRlzPZCf81wI
         cGXvHbzXwAlk4VY2BPzdA1fGDdekIpAvGsNksyy2woql3IwdWruED0haaHQnTbhhQAMB
         kkgUrxW++5ymeW0dcVdXCNSth0U1aOoRS4WWCYkPNarY7acgUN0XvWCUkWzc3ja/x8nR
         dgnSyLkgii0IgMbteZlsV11sqQlKht7dduWC7+aBGHLrfKcZdnNhMQ3GrCMJMvyRpbHt
         8C2grwl/1JF68CwUFtFBSG3VsL3dUv7B5w6mBwBnZxuuDd+BWLngt6SaeeoO1szYVVlD
         g0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740490761; x=1741095561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uT3CYG520Dq/1dijGlLbTlImqbVeMFyUskqf9mGklcY=;
        b=tPBqXB1nGU+3iLk/wVoxh4TOE0J51yzD5rqMdylksz6OEnW7ljAs5RTtttLVRzQB57
         N0vhl6i9/KkqFVEaLbLRPHe8VwjkaxJcDru+t9DfZDZ6fw8JFLBpylEB8uX5lW+FiGgD
         6TmQpHPql8Qp8M0vpW9pm+FWzd9Etdr8lUSxfSxFUNdCH2w2a77lZ6MT3YKF7uBxnRR0
         HactSbs0bmrtvzg/CB3+vUpvulydkW2A39Sbf7ubREKIbrtincFzA6EAyu1CN+WlPMUP
         k+v0GFnygglmZ3M299nKStkL9P3+/XHXaFpAJI/TJGDYZ6R+2nqse4FBUmm2MR0jC5LW
         RnaA==
X-Forwarded-Encrypted: i=1; AJvYcCVVQa7KK9IwVUl9MIBzrAl9pxqA3c9+6Ey6jG4G+BHKc93CUEZ5P+agInYG5B7m1VGdAf5K@vger.kernel.org, AJvYcCWdehCd/45EeoNT9s6cu20Wb9MA7JeNwiHoKM5W8Yf3fXKeLnKsolX+aKPggPtVdEAl49j1utfcmIU42Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcPIM4UUv9cY/NIgbMSe14wH31SW9vxet9aNp+Bjl6/IT9Sih8
	0hjZQta9uPxx72/6C4yTHeG4HibfIKioIeJ7raz5zDAoA2Iy+7W5
X-Gm-Gg: ASbGncvnztujLdaVTymJxS9q90YK3QuUbuVuToyU/YsQFhfzr3OeLdiDGoeRoHIyniW
	pA9VdpKqC/m4eDSjye/6eF5n8C6RyYTIWwpxZP7exp/yk3TCbsCLXv2ajdctgYA6s/VOSmTzdFu
	1Rc8mdxo6Th9xv3nIr7PVxkOhRwciFFQcsP08Aignr6zDRcozA59rCfBmhwPSqBfFDhzUopdsNC
	sZZLXDIQuBxcXI72ajtgh24kGQA4iUTkigZAS2/sKq3sz7ylB5A3+iDbLAYu4LOL/yUKndMgru2
	h2FQmdRbMdWntxSHZu+RKa7t2nboCcW7H1CQMW+4c6yywkvi
X-Google-Smtp-Source: AGHT+IFNV2rx8abzKJFcJ2A+jBxuuw5RrwkFtqBmny0yVTTzAz0hhI1h/FhGU/in4snmWgKvHrdp0Q==
X-Received: by 2002:a05:651c:2227:b0:300:3307:389d with SMTP id 38308e7fff4ca-30a598e5c7cmr69996921fa.19.1740490760754;
        Tue, 25 Feb 2025 05:39:20 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819f4a4bsm2372111fa.49.2025.02.25.05.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:39:19 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 25 Feb 2025 14:39:16 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>, Keith Busch <kbusch@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-nvme@lists.infradead.org,
	leitao@debian.org
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from
 kmem_cache_destroy()
Message-ID: <Z73IBMdk5fnmYnN1@pc636>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp>
 <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
 <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>

On Tue, Feb 25, 2025 at 10:57:38AM +0100, Vlastimil Babka wrote:
> On 2/24/25 12:44, Uladzislau Rezki wrote:
> > On Fri, Feb 21, 2025 at 06:28:49PM +0100, Vlastimil Babka wrote:
> >> On 2/21/25 17:30, Keith Busch wrote:
> >> > On Wed, Aug 07, 2024 at 12:31:19PM +0200, Vlastimil Babka wrote:
> >> >> We would like to replace call_rcu() users with kfree_rcu() where the
> >> >> existing callback is just a kmem_cache_free(). However this causes
> >> >> issues when the cache can be destroyed (such as due to module unload).
> >> >> 
> >> >> Currently such modules should be issuing rcu_barrier() before
> >> >> kmem_cache_destroy() to have their call_rcu() callbacks processed first.
> >> >> This barrier is however not sufficient for kfree_rcu() in flight due
> >> >> to the batching introduced by a35d16905efc ("rcu: Add basic support for
> >> >> kfree_rcu() batching").
> >> >> 
> >> >> This is not a problem for kmalloc caches which are never destroyed, but
> >> >> since removing SLOB, kfree_rcu() is allowed also for any other cache,
> >> >> that might be destroyed.
> >> >> 
> >> >> In order not to complicate the API, put the responsibility for handling
> >> >> outstanding kfree_rcu() in kmem_cache_destroy() itself. Use the newly
> >> >> introduced kvfree_rcu_barrier() to wait before destroying the cache.
> >> >> This is similar to how we issue rcu_barrier() for SLAB_TYPESAFE_BY_RCU
> >> >> caches, but has to be done earlier, as the latter only needs to wait for
> >> >> the empty slab pages to finish freeing, and not objects from the slab.
> >> >> 
> >> >> Users of call_rcu() with arbitrary callbacks should still issue
> >> >> rcu_barrier() before destroying the cache and unloading the module, as
> >> >> kvfree_rcu_barrier() is not a superset of rcu_barrier() and the
> >> >> callbacks may be invoking module code or performing other actions that
> >> >> are necessary for a successful unload.
> >> >> 
> >> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> >> ---
> >> >>  mm/slab_common.c | 3 +++
> >> >>  1 file changed, 3 insertions(+)
> >> >> 
> >> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> >> index c40227d5fa07..1a2873293f5d 100644
> >> >> --- a/mm/slab_common.c
> >> >> +++ b/mm/slab_common.c
> >> >> @@ -508,6 +508,9 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >> >>  	if (unlikely(!s) || !kasan_check_byte(s))
> >> >>  		return;
> >> >>  
> >> >> +	/* in-flight kfree_rcu()'s may include objects from our cache */
> >> >> +	kvfree_rcu_barrier();
> >> >> +
> >> >>  	cpus_read_lock();
> >> >>  	mutex_lock(&slab_mutex);
> >> > 
> >> > This patch appears to be triggering a new warning in certain conditions
> >> > when tearing down an nvme namespace's block device. Stack trace is at
> >> > the end.
> >> > 
> >> > The warning indicates that this shouldn't be called from a
> >> > WQ_MEM_RECLAIM workqueue. This workqueue is responsible for bringing up
> >> > and tearing down block devices, so this is a memory reclaim use AIUI.
> >> > I'm a bit confused why we can't tear down a disk from within a memory
> >> > reclaim workqueue. Is the recommended solution to simply remove the WQ
> >> > flag when creating the workqueue?
> >> 
> >> I think it's reasonable to expect a memory reclaim related action would
> >> destroy a kmem cache. Mateusz's suggestion would work around the issue, but
> >> then we could get another surprising warning elsewhere. Also making the
> >> kmem_cache destroys async can be tricky when a recreation happens
> >> immediately under the same name (implications with sysfs/debugfs etc). We
> >> managed to make the destroying synchronous as part of this series and it
> >> would be great to keep it that way.
> >> 
> >> >   ------------[ cut here ]------------
> >> >   workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
> >> 
> >> Maybe instead kfree_rcu_work should be using a WQ_MEM_RECLAIM workqueue? It
> >> is after all freeing memory. Ulad, what do you think?
> >> 
> > We reclaim memory, therefore WQ_MEM_RECLAIM seems what we need.
> > AFAIR, there is an extra rescue worker, which can really help
> > under a low memory condition in a way that we do a progress.
> > 
> > Do we have a reproducer of mentioned splat?
> 
> I tried to create a kunit test for it, but it doesn't trigger anything. Maybe
> it's too simple, or racy, and thus we are not flushing any of the queues from
> kvfree_rcu_barrier()?
> 
See some comments below. I will try to reproduce it today. But from the
first glance it should trigger it.

> ----8<----
> From 1e19ea78e7fe254034970f75e3b7cb705be50163 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 25 Feb 2025 10:51:28 +0100
> Subject: [PATCH] add test for kmem_cache_destroy in a workqueue
> 
> ---
>  lib/slub_kunit.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index f11691315c2f..5fe9775fba05 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -6,6 +6,7 @@
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/rcupdate.h>
> +#include <linux/delay.h>
>  #include "../mm/slab.h"
>  
>  static struct kunit_resource resource;
> @@ -181,6 +182,52 @@ static void test_kfree_rcu(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, 0, slab_errors);
>  }
>  
> +struct cache_destroy_work {
> +        struct work_struct work;
> +        struct kmem_cache *s;
> +};
> +
> +static void cache_destroy_workfn(struct work_struct *w)
> +{
> +	struct cache_destroy_work *cdw;
> +
> +	cdw = container_of(w, struct cache_destroy_work, work);
> +
> +	kmem_cache_destroy(cdw->s);
> +}
> +
> +static void test_kfree_rcu_wq_destroy(struct kunit *test)
> +{
> +	struct test_kfree_rcu_struct *p;
> +	struct cache_destroy_work cdw;
> +	struct workqueue_struct *wq;
> +	struct kmem_cache *s;
> +
> +	if (IS_BUILTIN(CONFIG_SLUB_KUNIT_TEST))
> +		kunit_skip(test, "can't do kfree_rcu() when test is built-in");
> +
> +	INIT_WORK_ONSTACK(&cdw.work, cache_destroy_workfn);
> +	wq = alloc_workqueue("test_kfree_rcu_destroy_wq", WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
>
Maybe it is worth to add WQ_HIGHPRI also to be ahead?

> +	if (!wq)
> +		kunit_skip(test, "failed to alloc wq");
> +
> +	s = test_kmem_cache_create("TestSlub_kfree_rcu_wq_destroy",
> +				   sizeof(struct test_kfree_rcu_struct),
> +				   SLAB_NO_MERGE);
> +	p = kmem_cache_alloc(s, GFP_KERNEL);
> +
> +	kfree_rcu(p, rcu);
> +
> +	cdw.s = s;
> +	queue_work(wq, &cdw.work);
> +	msleep(1000);
I am not sure it is needed. From the other hand it does nothing if
i do not miss anything.

> +	flush_work(&cdw.work);
> +
> +	destroy_workqueue(wq);
> +
> +	KUNIT_EXPECT_EQ(test, 0, slab_errors);
> +}
> +
>  static void test_leak_destroy(struct kunit *test)
>  {
>  	struct kmem_cache *s = test_kmem_cache_create("TestSlub_leak_destroy",
> @@ -254,6 +301,7 @@ static struct kunit_case test_cases[] = {
>  	KUNIT_CASE(test_clobber_redzone_free),
>  	KUNIT_CASE(test_kmalloc_redzone_access),
>  	KUNIT_CASE(test_kfree_rcu),
> +	KUNIT_CASE(test_kfree_rcu_wq_destroy),
>  	KUNIT_CASE(test_leak_destroy),
>  	KUNIT_CASE(test_krealloc_redzone_zeroing),
>  	{}
> -- 
> 2.48.1
> 
> 

--
Uladzislau Rezki

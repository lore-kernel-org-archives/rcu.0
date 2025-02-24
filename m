Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186DA2571A6;
	Mon, 24 Feb 2025 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397495; cv=none; b=AOc3iPSnPFt68WGQOYltHnaDulyQ0sTmwlRz/Sc5RuWfYsTAqahimebYAMjUWW4541ajq3Epdlbn5MfvhkA4R2vDfWoSkAR8LbBkGSZWwEqZy6PNtdYqmMzM6XCh6Bc8jViLZtsUF3jRAtArbcx5uCGEXTTMvg7BkbH9ZdMqbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397495; c=relaxed/simple;
	bh=Zu79/T5xgk6aU3TyyEiaQRznickGnYILb1+WR7Etch0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj1xIqMcFaxrp1ooujAeEIyN+eo8V0rEqkVXECIqhh60hUTBu8mL2WPYCxszCWVjTQR5ZugY41GqnA8hb8myw8VBd7V1/+gmBwsrCIN4qScm/ZqKmc9VYfxoC1Z/4G91XLjfFrr2QnvEJeeF0ol+ZcA344I7tTLOpzBUVCpuwKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKmcT/kX; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKmcT/kX"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54298ec925bso6236354e87.3;
        Mon, 24 Feb 2025 03:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740397491; x=1741002291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GKmie4ql2EMQXkPV0dHeKHuPylk+abYCTsODvoG58iw=;
        b=fKmcT/kX3db6dpe9d7zlne434JOKEMjOcrQo5qbcPJP7LLSmfQYB7gH5ampYtWScWR
         2pJEocIPNFePYIYsPfkfer9tITqrej1SKPbvm7wYAwyOoVE3wsV7erCfnpftzZm9AbZk
         Vw9cYqqEHZA6GA6AlbXf9JdAexFFfv0rKTNCERhTmlOVMArnoxrTgS2SA9ejDp78Pm/W
         03yW4XjlAmpYFG+Ie/dzKmucwgfJHt1hGgZ/M4AY11C6GjAe9isNuAgRLP1ocM9EJn8h
         jhLmHYqcfl6DNta7W5o/6jYC6zmGntq+3TepA7NUEfh9U0EJyDOlR+Z/WGkCcxNhVRlY
         3L+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397491; x=1741002291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKmie4ql2EMQXkPV0dHeKHuPylk+abYCTsODvoG58iw=;
        b=t0w/QfmzXBUjntfm8FdlYM1EgGqi6WN+L+x3GRGLfsMunlyDhdVjkX8gMV03iM2UnD
         txpi27/Q5l//9wyj4CupZgNZaDuvvdweI2HsJQpV96/JC5pFE/QPtzielLLOwchJxlrL
         ZM91N4asVl+dt58+FV04o5t2SGeg3YOA45JxhW8qSE+CMKt/M6qQlikQ9p4IGTkv/e6Z
         +ZiahiwskaMihjGrluMDhW6gaFewrv+li2Y8IBnUw0CpvXlndrrAi+Snd+seTv+HWxaJ
         4aIDAZ6iQQGJ3sVvO3kLgcQjNk74iIpq1IUoKive5oAKMlsBrvTcpLEeyZQQ7R7tAtEB
         Oidw==
X-Forwarded-Encrypted: i=1; AJvYcCVcG+yPvDrU6KIBWrtJA/eAfWA/7aertf8gzR4SSbYt/72RVFGxSa4jJNoTu4S4Ll9KOCWg@vger.kernel.org, AJvYcCVy5YekiU/65VsyHYuU9AB0B+AJPNygHw9Ok51ggQdgppCe+Vpwp+I4j5dZF2pFXT0qthffdS5d/+wzPeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1div7MSpDySX8FuPznL/U0+NtJ8VN/m4w3vxhCeGDux3MP70X
	ABkOZAnnkOzjRrqYMAFuhkk0j4olP/RvbiSbj1t2rQ/1ZbqEBXf5
X-Gm-Gg: ASbGncuGEZmNOVVBMV1xVopxiFLS8P+G9llm1Ru46Uf1Dah4G0gI12l2Gv/6Y1Dudcx
	+/CLkMwwjoBxbr8RKeuCsObM7t4YtX8IYsoKbzdjjv/FocgVYloItSgVK/+Tad0J5xfKBZtApZk
	FthUlSzMyfs4eCZkMKUGp9/LojxdjhSSPPX2DsHVlIa0g8IFXngkjAQpt2p0wH2ZKR/qyFdePcv
	tH5IUAKV4fB88okZawGZB0HCQaGQHOjVnP7vm4k8iavXggHhh+lg0s7lsBEx3RCF4JsM12hMPpd
	yjKVm0GBIUIlpegENLnB14TggFF40heik6bUgC07jwnt14SL
X-Google-Smtp-Source: AGHT+IGjbXqoMdV+6yP1nHJ/PGwFmTUOZnYyR49KFY2a21Z1wZNQdeD93xJxOmEV3IxFMucNPB3mfQ==
X-Received: by 2002:a05:6512:1244:b0:545:1104:617d with SMTP id 2adb3069b0e04-54838eddea5mr5695115e87.11.1740397490753;
        Mon, 24 Feb 2025 03:44:50 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461f541653sm2376875e87.156.2025.02.24.03.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 03:44:50 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 24 Feb 2025 12:44:46 +0100
To: Vlastimil Babka <vbabka@suse.cz>, Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>,
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
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
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
Message-ID: <Z7xbrnP8kTQKYO6T@pc636>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp>
 <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2811463a-751f-4443-9125-02628dc315d9@suse.cz>

On Fri, Feb 21, 2025 at 06:28:49PM +0100, Vlastimil Babka wrote:
> On 2/21/25 17:30, Keith Busch wrote:
> > On Wed, Aug 07, 2024 at 12:31:19PM +0200, Vlastimil Babka wrote:
> >> We would like to replace call_rcu() users with kfree_rcu() where the
> >> existing callback is just a kmem_cache_free(). However this causes
> >> issues when the cache can be destroyed (such as due to module unload).
> >> 
> >> Currently such modules should be issuing rcu_barrier() before
> >> kmem_cache_destroy() to have their call_rcu() callbacks processed first.
> >> This barrier is however not sufficient for kfree_rcu() in flight due
> >> to the batching introduced by a35d16905efc ("rcu: Add basic support for
> >> kfree_rcu() batching").
> >> 
> >> This is not a problem for kmalloc caches which are never destroyed, but
> >> since removing SLOB, kfree_rcu() is allowed also for any other cache,
> >> that might be destroyed.
> >> 
> >> In order not to complicate the API, put the responsibility for handling
> >> outstanding kfree_rcu() in kmem_cache_destroy() itself. Use the newly
> >> introduced kvfree_rcu_barrier() to wait before destroying the cache.
> >> This is similar to how we issue rcu_barrier() for SLAB_TYPESAFE_BY_RCU
> >> caches, but has to be done earlier, as the latter only needs to wait for
> >> the empty slab pages to finish freeing, and not objects from the slab.
> >> 
> >> Users of call_rcu() with arbitrary callbacks should still issue
> >> rcu_barrier() before destroying the cache and unloading the module, as
> >> kvfree_rcu_barrier() is not a superset of rcu_barrier() and the
> >> callbacks may be invoking module code or performing other actions that
> >> are necessary for a successful unload.
> >> 
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  mm/slab_common.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >> 
> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> index c40227d5fa07..1a2873293f5d 100644
> >> --- a/mm/slab_common.c
> >> +++ b/mm/slab_common.c
> >> @@ -508,6 +508,9 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >>  	if (unlikely(!s) || !kasan_check_byte(s))
> >>  		return;
> >>  
> >> +	/* in-flight kfree_rcu()'s may include objects from our cache */
> >> +	kvfree_rcu_barrier();
> >> +
> >>  	cpus_read_lock();
> >>  	mutex_lock(&slab_mutex);
> > 
> > This patch appears to be triggering a new warning in certain conditions
> > when tearing down an nvme namespace's block device. Stack trace is at
> > the end.
> > 
> > The warning indicates that this shouldn't be called from a
> > WQ_MEM_RECLAIM workqueue. This workqueue is responsible for bringing up
> > and tearing down block devices, so this is a memory reclaim use AIUI.
> > I'm a bit confused why we can't tear down a disk from within a memory
> > reclaim workqueue. Is the recommended solution to simply remove the WQ
> > flag when creating the workqueue?
> 
> I think it's reasonable to expect a memory reclaim related action would
> destroy a kmem cache. Mateusz's suggestion would work around the issue, but
> then we could get another surprising warning elsewhere. Also making the
> kmem_cache destroys async can be tricky when a recreation happens
> immediately under the same name (implications with sysfs/debugfs etc). We
> managed to make the destroying synchronous as part of this series and it
> would be great to keep it that way.
> 
> >   ------------[ cut here ]------------
> >   workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
> 
> Maybe instead kfree_rcu_work should be using a WQ_MEM_RECLAIM workqueue? It
> is after all freeing memory. Ulad, what do you think?
> 
We reclaim memory, therefore WQ_MEM_RECLAIM seems what we need.
AFAIR, there is an extra rescue worker, which can really help
under a low memory condition in a way that we do a progress.

Do we have a reproducer of mentioned splat?

--
Uladzislau Rezki

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793841770;
	b=UettbfPRmsT+7dqI15yDmTEDh1FR1DREZmVqKakpPW83YL+o6q+kByUVF4Nbi3v3/YN/
	 PvO51dV3sQHHb30Hcsxk7jVRtH/burO9jPl6Zj+GEUgZbjxchW08vHWj4qF++ZtiZyfMT
	 iGPU8bd3b/3F3Aays/cSaQuQ6mFt1YwSKu//jaToTTR0IhmAnsJ/enepu3p2eaPvYHC9n
	 tjoyXbR02z4uM+U0C8hxjB8+peHAZHlby5ArQcZi6z43tEIUV4mnIER1kmhazNanxTSHt
	 5aMr5ts+eN3JBTAfpGl62NN71BGu/prVRvUmythn0hvET7Kp7Ust14vYCS9JlTdJPOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793841770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PW259vEwVt6aepdEMnV/kf0Mt4lpxnzMAqh8bDDexfs=;
	b=w4VwpZ7EiULN50US1p5aUHsg5YT4fUTgn4IZgBj+C5iuuObT5H0/YeQC4AJvo76B9EVr
	 bRHDTagQApZkJIaYOJxYoYp8u6N5ILBxWoH/Kz9b1ViJryAldIDJYfZP4Lu7TiOu437q9
	 liXZ4F7MEMK8DId+GNdDTCVBOeBw86hzbKiegtYytnvxo8ExxCdPK5ch+XA1FCIJPpzpf
	 9MIiau5jFP0H/2916T6O9snpbCLgmEEyyn/TafLwOoxlHMAgHtZ1rPcogshuhjalcXOYq
	 7hFRBD5GiWMzM0wqIb4lx0gdM50XHTgfOM1KRK5uRfVNcKUie8qKbJNwJlND8+kU8ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wXXqLWq5;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AAF606A31B
	for <rcu@vger.kernel.org>; Thu,  5 Nov 2026 01:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53AAF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wXXqLWq5
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-15dd124bbe7so291939c88.1
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 17:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793841769; x=1794446569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PW259vEwVt6aepdEMnV/kf0Mt4lpxnzMAqh8bDDexfs=;
        b=wXXqLWq51EnKuCV8eczEg3m42Y8tLQoCeEt86ccSCmBF8iNWxTJiWbe/B5I9DX0Dam
         22BJ8WBPO1YrCZ6oc3u7dsit8THwZqmLvi3BWEly3Nq5gnMiXRcMrOJvIVOmf9Jbz+zt
         grivGH0X685Zjrt9HwEfUbejqxqsSN+I909TqS8Wbhi2BX0lWnGKjYBV7mjpAYDuILTn
         tbVRrbpIkAkYONNJuN5e6yaj/rmSDzAmSwjeGZN4EFKBOQpwbilT2eiS4KFAy+gWAwCt
         2JIG9VZ+5tD0O1GsVvVZyg9cSjLOdqQVqo+QvkBrF2PaR6ttnUZMv+Uv//WQovl1oqk/
         lvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793841769; x=1794446569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PW259vEwVt6aepdEMnV/kf0Mt4lpxnzMAqh8bDDexfs=;
        b=Tro8TOB09Ds5an5CTIfA5k4+DIUmdJ26Mt8n2Cft0gL1OHxUWG7o0DYXw1vuDmfWZk
         NsMbi8RkePAmf1NL+EYvsJBeosnDzTI3BZJkE/kn55sdfIcIH7r9dp/3FRBSj/eceU6v
         SMn8Pb96vA6a7nC29E4fEN06dM4V3ClqgQuki+jCrBpeErQdWRn6U5sPPIcuVWoc8udA
         naacIlJEM3nBQzbqSAnwHNNB5rl9jFSJRWWK6nyhLl6HuF3taruXhXpB5eN0L/fc8lIF
         xuBpOBHxn4i0MTmik3EuD7ovELbThLWnBK8E5PM9ZHqjqIHD44VUVB6fov/XjbUSZZwR
         CmdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxlmNPvJ8qIhLBS0IV6ehZUtRbsN1fXYwGBjtOWyfWe0hQJDk4D4I++10HZGIpYb/B1es=@vger.kernel.org
X-Gm-Message-State: APuU4Z8O0Oz/tNHT9bA1SBzxRaotTy8bYoVJZ/Fqx80YBdHEXLuPYfXW
	wjhPag2z4aEBQKv6rvjC1iidpZ91TPwl3UepZWWJAIyCsay46pv3k9eq
X-Gm-Gg: AYBFou0wOwrmHJQTxyVBZoFlK3XCDYlVZ+S4Rr7S/+Gd16KBy0ihVpgowQDOkGM/II4
	paUiypdWbVAr82+ukIA3RQZNqxokPHtsTMxEbMLSkaOtYiLkYJ6kdyrsdlczP3LmVQg6SIUWBVx
	h1Jmu/OE7Yx1X+MMfDJMsdFG5++KOA7y918D3d0AsiYCmXtq3F7YFVk/iRW5y9jQqSUk+qgEaWi
	8LvY/khRd4NdomL/qzp4PM733r2TADgxd0aisPOgrhc3nkeqMzdy5lD6I2o5Zg6ytnP0sE5dPfM
	878ekGwOilPEXNPMQP07C3r3sEm6b/+1muHXqb4Pm1NaIsFmcz+0RkLzsJRbmUanDzm5Ht/huit
	DOkjGLLDp3jk1XjhQmZDr9rYHOXZVeIsA8ZITwzqkjwseFLlGSb8np7/we0loWub9F+umjk39h/
	EBaTKL7PUzn3SlLJaJK5bTHfid1s93tfWB+SaeJBUja+KPVMM7oEeGEO8Ae833ALZeTj6t8F8by
	2+116y8pvKxHXqxscc2O2kcYl92d2WJrZ6OG13vsn/kuTCP3lu1G7R+E+wLB1wMV7q2ZvVqRDur
	kFd9/Kl4zSjbSR5u5rRF
X-Received: by 2002:a05:7022:281:20b0:1ac:91b6:8dfd with SMTP id a92af1059eb24-1ade9e3e335mr25492252c88.31.1793841769331;
        Wed, 04 Nov 2026 17:22:49 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1bcedsm11526499c88.7.2026.11.04.17.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 17:22:48 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	=?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
Date: Wed,  4 Nov 2026 20:22:42 -0500
Message-ID: <20261105012242.623962-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com> <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com> <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Nov 04, 2026 at 09:14:12AM -0800, Paul E. McKenney wrote:
> I am not inalterably opposed to adding a list_splice_init_srcu(),
> especially if quite a few more users show up, but here is what I was
> expecting people to do:
>
> 	static void synchronize_my_srcu(void)
> 	{
> 		synchronize_srcu(&my_srcu);
> 	}
>
> 	...
>
> 	list_splice_init_rcu(l, h, synchronize_my_srcu);
>
> We need at least six uses of the above idiom to break even on the line
> of code required for introducing a list_splice_init_srcu().

That works for a global srcu_struct, but nvme has one per controller,
next to the list it protects:

	struct nvme_ctrl {
		...
		struct list_head namespaces;
		struct mutex namespaces_lock;
		struct srcu_struct srcu;
		...
	};

nvme_init_ctrl() calls init_srcu_struct(&ctrl->srcu) for every
controller, and readers walk the list under that controller's srcu,
e.g. nvme_wait_freeze():

	srcu_idx = srcu_read_lock(&ctrl->srcu);
	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
				 srcu_read_lock_held(&ctrl->srcu))
		blk_mq_freeze_queue_wait(ns->queue);
	srcu_read_unlock(&ctrl->srcu, srcu_idx);

nvme_remove_namespaces() thus has to wait on the srcu of the controller
being deleted, which a sync function that takes no argument can't get
at.

So the choice here is between list_splice_init_srcu(), as Christoph
suggested on v1, and open-coding the splice in nvme_remove_namespaces()
as v1 did. Which would you prefer?

Thanks,
Qiliang

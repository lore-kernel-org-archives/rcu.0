Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351482F4A05
	for <rcu@vger.kernel.org>; Sat, 11 Jul 2026 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749382; cv=none; b=Vb5gntd/P4/dSwU+00ZHD4gZczlb/uageQ90/2jeW1ndcaGgkCrqGtSzMD037jiI4wmrGkYw3ZEjuwIG+7VHkesG1JXd+v3vT7sFhveSbxPJVsgSU5v+mJLq+7aLyKNhmq/nf7fwbYV6WwocayvJwgbaVz6NMFqTjRy1YUAtUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749382; c=relaxed/simple;
	bh=malqePsjYETlp6YRyNOGcOnY/0Qdf0rdTDZd6rzljMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+so5MS+S1+ouDzoiX8FviOe16bQF3lCU7nCOT/osXaE6lSGM0iNhmYQHQstoLWe0z2CF0ZUBzA8WcuDXtRulYEahiO/biQbue4PRGbbGdQ3qtLR9FKElQSyFBjadyL+ToOSONZ0RY0dtPM2NpkF+JPdT0y7oQshGlhBoopdlLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=FCif4/8E; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="FCif4/8E"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-476a130c138so1931657f8f.0
        for <rcu@vger.kernel.org>; Fri, 10 Jul 2026 22:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1783749380; x=1784354180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JXWYlcHV8kyBocpQgRM3YOKQ4YhOMcY53dOQDtkUlDg=;
        b=FCif4/8EfHYX/HpTsHnAQEKzqbWqPB30b12/ayje7FwtEZAYmhV19kqdLsTGNYV/ls
         444eE3zKR3xtkih4J2+dcIi4DPZPlv+pB9fzBSZaXSt7Vzb9tuhwGw78EK2XkuQDueIZ
         wodkL0N5ORCtXqS6ZAkJe6eBJq+CidrUq58Ps3HsPDchpu/NeGoHxnxEqoSADPO+uBdd
         K9fJL/uVGlClgI0cNLWWHczT+WKF9D570oWq4fysGRwwJDdGoWOKv3ZMHL79rgDdFBvn
         Rc+5Ut2h9KiWE15n8I1pGcd1artIgTcxJwyhzL69w/0FKhTY8lV9dDAz0BH+xKqZeFXi
         lYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783749380; x=1784354180;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JXWYlcHV8kyBocpQgRM3YOKQ4YhOMcY53dOQDtkUlDg=;
        b=Z++NnUUSMTtVZAH857sypfooimXJYxVWfbq0CExcVhyx59Z8K7siPwR2Swdd7LqYwV
         ZkBt6LGuq5Bw/iPiwIjlWVmI7nI07O/CQyvqSgE0wb75ZfBxL9evhhxtC5RLBjxygrpV
         cWA4xsVr4MGh4hwWcb7DH6CmFyXXXOAkXan5s7PDgIXFgBV9g+y+YcLVhwWqThvCFvin
         0cMi4iGROOJGW/x12VAiD6RjLTCgJWROMnpiJvjfYv13BMCGf8HEbIKARWBVGCzFQWw6
         V6vtW7gIwpbYDH0Yv8u/QhMrRxc+r1mosGMM3Uj/a+dn+1B6YQNJ8TFae3jawDGcfmsA
         JHwQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYbO92SIDtv6492z1A9CSSS8GvtnI4VI4tqUq1zJioihXslOXBaLXaCRJc7fLpc1QKhZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7trSTVsx1aI8CEStjTy44PDNM72s17zS8w9OaqnjgC310vZbH
	ah5/gzh9joYHoehukqj/gBsC7dZ+7zt9KXuQ8mX7jwmLXwYFGJeokL1RuVfX5RfNWEs=
X-Gm-Gg: AfdE7ck1pmy4B3rVqsyS0LBxNP4JPYz0MWCqZ0DUZpe16+FBO06VUvhExc+dIbM2sH7
	ax9VTNAhWA3vugLVw6fbg28Pl3U2JkiMiXdqxCyHWueMdh3OSam3t3ho6L4hxLY8d18H8CvF60z
	tg7lPFapR3KmK4AuDn6+BqR3tK+4aiQDkwVgaVaQddzCxhMAo7uFpddUW3NOfdKjQHI4JjhzvCq
	1/afcsgrDfwdOpbrGt6zQ6spxed6Oi4zKGwRVrH7YRxbdstCbjQnOIOEio3KzusVRwa1O+PNcVV
	3XcEcjG6+WVxnqN0q/JMYE4/T04rDtXNnJF8O4jPV/xA8PIfIfxxvX0sdJadv+Opou+KNzvyg3g
	jjoFcahaXO/jfPzM3xPXaHervHuHJagRBdj3UO8vNEGlZhJV0Y6+sGWOOJ+15INyuDNiirdfV4y
	8=
X-Received: by 2002:a05:6000:4a05:b0:47f:2906:b551 with SMTP id ffacd0b85a97d-47f2dd2113dmr1544164f8f.32.1783749379539;
        Fri, 10 Jul 2026 22:56:19 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:26dc::3df:54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm65233731f8f.13.2026.07.10.22.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 22:56:18 -0700 (PDT)
Date: Sat, 11 Jul 2026 06:56:18 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH 6.18.y] rcu-tasks: Defer IRQ-disabled callback enqueue to
 irq_work
Message-ID: <alHapJgHNRea7eZz@matt-Precision-5490>
References: <20260710095359.2643791-1-matt@readmodwrite.com>
 <886c23ff-7dca-4679-9d2b-ca499523853c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <886c23ff-7dca-4679-9d2b-ca499523853c@paulmck-laptop>

On Fri, Jul 10, 2026 at 11:16:27AM -0700, Paul E. McKenney wrote:
> 
> This does look plausible, thank you!  However, it does not apply cleanly
> to either current mainline or my -rcu tree.
> 
> Judging from the subject line, this is against v6.18 rather than current
> mainline, correct?  If so, would you be willing to forward-port it?

Yeah, my bad. Since the SRCU code in mainline fixed the original
deadlock I reported I kept this to 6.18. But I'm happy to forward port
this patch too.

Thanks,
Matt

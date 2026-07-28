Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1923E5EFB
	for <rcu@vger.kernel.org>; Tue, 28 Jul 2026 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785235179; cv=none; b=hajzihQnd9PCx1Ue6xWk/qv1afU211mSLsw/KimKa9NeEa4x3TIe6GwYbPK2j9aIwHQmiHKvQ6WTIDxizAz4PtV/cBjogh0lbiXnKfozgVrb9pFbZWBUE3bTnRjpKr0TW+KqxNdmyZ54+HeRiE1gUU8ldwAzdOBTVnDbKeMXKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785235179; c=relaxed/simple;
	bh=qpSpYBhIpJtMXaX73sqUbb/dClW7iZn/LKMcEnuzdf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJ7ejkZZWOzI6FpPSpxmYm6mqa15+4ToJ/1I6wM9xEos3TApRZXEbzNO+9tEBpvxH85yLDGZGXmtoshDdQU/cgjwGk1r0INUK1CDIK4LWzRUpqr28Uj+hJNajyttRzCN1Fdv7ZvR8B8XH479aIkxsvm750FACjPIGxBy9znvAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=vxiw03eF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="vxiw03eF"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so25730895e9.0
        for <rcu@vger.kernel.org>; Tue, 28 Jul 2026 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1785235176; x=1785839976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hh9GGg57kuY2hD4zZm36wFzr1EZULMRj8TJL33H+8H4=;
        b=vxiw03eFtILF+s2UA+7KBEoxGjJN0LQk7pqq+NYOJl82o/1bQP9NtOM9v4EE3GqyZ6
         GjhURE4JmrA6p8oKk7lW/4udmtMcCTgFCBiFftpfVvx++lR7nd7QTiF9LQodSsOnUHwg
         Rs54acEcdf1s6YXcvsyP0tZ9qkjscoRlEycODA6GuYc3mBWKEHq0FZ01qRFcKvXLbzmq
         mKlM5Hlw1/dGoR01dphWanPmL+EhrvGZE2pnsl9qRiJ9FmTLq6YkyK2LnmRWG162ym7H
         xpUwkXH8KRgT+uHUwnTvS1lJzAraiXdEjJiPViIwxnBSZNItGjHGKrhLtKBg9pBr4BOY
         dM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785235176; x=1785839976;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hh9GGg57kuY2hD4zZm36wFzr1EZULMRj8TJL33H+8H4=;
        b=sAn1RDbM3v9PoHIkhaxLEJW2MgK0wFB7Ov6Kd73mcr3HAtEjxvBGrjy6iAkPDKHB7E
         y9f40zG19/CRjtbDQjN3Q5JrTlElJxZmtx0Lud/6WGh5gLAUnfdRAERXlAgsklng5kjM
         S4uUIK4SqeX/ljDBM5FGdaigOWsfl/Z20eZuKqUrlXEL6SLOFFtwz0scoSSvJVF7N2He
         n0LoIqb/Q04RmdeZQF2DYWFCV+7wpUkNs9Q9Q3OSZosz1xVtPBamGjjE9avaB4vqcwQK
         ZeiscjJ8y6RqWFSnqLDrp+hvHbakSHfbGQ3+CvE0G04zp0zmMQ778rGp5ShFV6/3k6uU
         bboA==
X-Forwarded-Encrypted: i=1; AHgh+RqWX0Sz73r57ci69SdSVkyo9bH4YXfUrJllx8R0trjQ9y2xofMFL6FLxCRbYG42ae6Bwww=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc8n139/tY/tqgIfr090YyoyOTZTKdFFSNpPSOzCtqqsZYuG2h
	5PdIq08Ah/EFgT41OTsRakhLtCFTKpx+IS+KHY5qawZMFDXBjfRxO2n4TPsyt5G69oM=
X-Gm-Gg: AR+sD1354Cw2SMXo0Zss9GzaTY4DvLvq/A6puPN15t6/LG471S2ha2YSV3Bxg7evARL
	hDNo75WYSihGPO/56SnOIGaqHu/RItXkRPS6ED+wWVayVyKtiEtUysJnAJz1uY+G8Jja4RHuGBu
	UwbsUpXhnHJAcBlKHTds5sUqq82Y9dXrP8u7kNs8Nr3MPDYJeFM+9xMcAaLhumze832jY743wiI
	EW59C6GgAcga9/yEgB/yHpIZCgFV34ZubTRrmmQX1pmPOumA/AF6uZhyRNS3qoetWrMCy+y2uyi
	YNkcLlf0PAOS27rzCjxpeQMc48aGGhxo93cmJnuxnwil/CsVACGUvq69ijA7LbeZ0xtiWlKeSxI
	gjw2hg+7Ru5YJp/UtLJPIsJJ/mKjTZhck5pi//Qx4K1ASA/LPDryNbt9r4TGK8P/Q+ket4Akb2Q
	==
X-Received: by 2002:a05:600c:8b74:b0:495:4b42:8677 with SMTP id 5b1f17b1804b1-496c657651cmr19071605e9.18.1785235175708;
        Tue, 28 Jul 2026 03:39:35 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:26a0::3d9:b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfd1a60sm293299405e9.2.2026.07.28.03.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 03:39:34 -0700 (PDT)
Date: Tue, 28 Jul 2026 11:39:33 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH] rcu-tasks: Defer IRQ-disabled callback enqueue to
 irq_work
Message-ID: <amiGJWJ-tzUMYizu@matt-Precision-5490>
References: <20260713101245.3207634-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713101245.3207634-1-matt@readmodwrite.com>

On Mon, Jul 13, 2026 at 11:12:45AM +0100, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> call_rcu_tasks_generic() can be invoked with IRQs disabled, and on
> older kernels this exposed an ABBA deadlock against the scheduler
> runqueue lock via sched_ext's task-storage teardown path:
> 
>         CPU 0                           CPU 1
>         -----                           -----
> sched_ext_free()
>   task_rq_lock()
>     raw_spin_lock(rq->lock)
>                                       rcu_tasks_one_gp()
>                                         raw_spin_lock(cbs_gbl_lock)
>   scx_exit_task()
>     bpf_task_storage_delete()
>       call_rcu_tasks_generic()
>         raw_spin_lock(cbs_gbl_lock)
>           <blocks>
>                                         _printk()
>                                           console_unlock()
>                                             try_to_wake_up()
>                                               raw_spin_lock(rq->lock)
>                                                 <blocks>

Hey Paul, it looks like this didn't get picked up and now won't apply
cleanly to your tree. Should I submit a v2?

Thanks,
Matt

Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25747C6C1
	for <rcu@vger.kernel.org>; Tue, 21 May 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300234; cv=none; b=a7MUyoCFdONDU+RrQET5w+/B54cFqcQVtvR98cg3CpuVN9v6n+XZjgV8PIbnGGURhxSQSmqv02SSlL149dxSGSbQq3dqz8dFWfVD1vXJThdbEPLqxc/EzATJF6g85pVST1j6cIYtrZmQ/S1dALNtsO9aXtW9QXIfelCwE6ch9cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300234; c=relaxed/simple;
	bh=jD9lqUXVtwzsplzjO6LumEIjzZ8PUD4gwVqpPcQiLzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wftp5lA2c2nkkuuQK3bmCrB1YEDyA5TawUuCVxYo/oevOAvJi33ntYMsyymrnQGR3j6pMRWAA4oRhNZWayrymGZRlKfgXwkXX2qqDjA305zSl+pcM6l6wk10Qq3M6O1DNaGG4a7IXdWYoDpmO6W8lPRAAm3mOmz1Nyw+2gm0lxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FF5lPCJA; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FF5lPCJA"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so11912624a12.2
        for <rcu@vger.kernel.org>; Tue, 21 May 2024 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716300230; x=1716905030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpCzsF2SjpoS+vP9sOIIVwewUFNHOIPX1cF6BrhM6sI=;
        b=FF5lPCJAvLfgmJtSIfN6TUaF/cyilaBngzMtQ8wgEO7gD1RpTox8bX35i4a8LI4Tcz
         twh7vkye+KfG8nXH4L5mYi0QzoCTQo7oYf2D+nihqlf0Uh5NbX79DdQSPUKahWD1A73U
         78IMc75yde2DdRKirezXNP4mgMdDZRA3Nwn31dHTJovaMsXTJJDqW+MraVC9dIJbjzR0
         HTvGrXFoV1LCHu1xjZIoNULyDkqnaX0yBaKuUVGtq2/Fmsx4lluAtcTDDzodAYCgUdj1
         ADl9aUB6hTuU4Tz0cXDeXMA1FgmjMQWHWQ2d8VSO8ZEr4wAi3VETuGBJlMnj6SfIKCmv
         lRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716300230; x=1716905030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpCzsF2SjpoS+vP9sOIIVwewUFNHOIPX1cF6BrhM6sI=;
        b=ckAXHOst1XzZFQJlSnTPvBHlw8qzFtCOkb+TTz1Zdmov6dp+P4i8cte1p7bK4SxujK
         YriTaV0FcXQS9IktM6ZggcsqxujAwTMhEtyF3Quys3Az1t33beFfbSYyjf9FakKYUz4K
         ZGmVYCiSJI+WQP+QTtZd26689KBNm71MSIuWbxfy7ylLiY1TcIaKhJqVNN2YlgBcDN79
         0Tj9RzQkTbfoEHh6Cj6+DMd7x19xqBI2aBY3oDrat/kHKFwJ+pnzPEZ92lxr01ThKx6L
         rChOhXwXPx1jIeQVJOqDDXFVjRVJC3MK/4JAXyJsMcFfASaB1X5J2ThYLnN5NxTJvUKf
         ZAPw==
X-Forwarded-Encrypted: i=1; AJvYcCXc2QEk0XnUFRfAVEAla2zfHwN4u1UlzX+yGHUfDsaeM8eGLDnuECKTh2Dn4mMCkjfa9zcYsnbiyD6FLnFzPaIe7BIv
X-Gm-Message-State: AOJu0YxpQ3zHQHS0pv9fv4+jO9r/t/YvfaoAwE3LuhecG6//U3fhcuOi
	8UitacH79kTIXFAWXqibrflWJ3tl3zyfkMyvoBN9hBwKzx3vRcPCnODOeCwg2ic=
X-Google-Smtp-Source: AGHT+IG2bIy86vwiqfSU9GGrcx0KTTzCGWnAuIiXF26lYQRM7jgWytH2FgVjnrjwz0GNvh2Qrdq8UQ==
X-Received: by 2002:a17:906:7fca:b0:a5c:e43a:2bd5 with SMTP id a640c23a62f3a-a5ce43a2fb9mr1375382266b.59.1716300230207;
        Tue, 21 May 2024 07:03:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b1771bsm1603365066b.215.2024.05.21.07.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:03:49 -0700 (PDT)
Date: Tue, 21 May 2024 16:03:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v5 29/30] rcu: Mark emergency sections in rcu
 stalls
Message-ID: <ZkypxKBSPPGIo9Se@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-30-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-30-john.ogness@linutronix.de>

On Thu 2024-05-02 23:44:38, John Ogness wrote:
> Mark emergency sections wherever multiple lines of
> rcu stall information are generated. In an emergency
> section the CPU will not perform console output for the
> printk() calls. Instead, a flushing of the console
> output is triggered when exiting the emergency section.
> This allows the full message block to be stored as
> quickly as possible in the ringbuffer.
>
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -612,6 +616,7 @@ static void synchronize_rcu_expedited_wait(void)
>  			}
>  			pr_cont("\n");
>  		}
> +		nbcon_cpu_emergency_flush();

It would make more sense to do the flush inside the cycle after each
dump_cpu_task(). Something like:

		rcu_for_each_leaf_node(rnp) {
			for_each_leaf_node_possible_cpu(rnp, cpu) {
				mask = leaf_node_cpu_bit(rnp, cpu);
				if (!(READ_ONCE(rnp->expmask) & mask))
					continue;
				preempt_disable(); // For smp_processor_id() in dump_cpu_task().
				dump_cpu_task(cpu);
				preempt_enable();
+				nbcon_cpu_emergency_flush();
			}
			rcu_exp_print_detail_task_stall_rnp(rnp);
		}


Or maybe, it is limited onto to few CPUs by rcu_for_each_leaf_node(rnp)?


>  		rcu_for_each_leaf_node(rnp) {
>  			for_each_leaf_node_possible_cpu(rnp, cpu) {
>  				mask = leaf_node_cpu_bit(rnp, cpu);

Otherwise, it looks good to me.

Best Regards,
Petr

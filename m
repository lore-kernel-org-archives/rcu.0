Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6391A01D4
	for <rcu@vger.kernel.org>; Thu, 19 Sep 2024 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755719; cv=none; b=Xf8PH99sE+zVOXAvKbgw6IvTn4A0PSGJnFGIp/HQq8ooNd49E0BnO9LRVP6PXafu9E/x4JZtwyX/NzIWeBQa63XwEa7hi9ptxrOgaqAmYMB3ixRx96KRnlxQSa9hI/xlYSdM6n4L7kOPUYVgqtKwBeopHv0P4IZo45fZT2MFs2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755719; c=relaxed/simple;
	bh=EG19uk4anwjgPAwhmxOvnDB/r3ED91HytRD3gv6bjK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+qznoS4Xac8J/mSOKm1uYR3k1Aeo76ekuT+X+zUkNqYS6xT/AfIyfg3dyDXKSKGoZb0fIc8KzyhEsFYDlhTyT1IH2SD0wCM/GCytxRWOcin4oxG1o5yDCOZpeLXltXTadgNWrsangWxCBvAIK/8G6Ufl8iXfNm+S5/AgmW1nrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JrSkgph8; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JrSkgph8"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso10521791fa.2
        for <rcu@vger.kernel.org>; Thu, 19 Sep 2024 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726755715; x=1727360515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cMMz1PNX68fmg9+skh8c5Nu7ndZ0JGeQo3cBldmTxJE=;
        b=JrSkgph8TLVW0XZJfcsojGvkpbH9+aC/zUzTvWIBoUiO3u8+RtqlRZ7dPc1zsuKWJj
         irZD8buCW2u/Kmszo5KdKdo6QpCcrTJ0FuetVsqwZDJuUcDqBSzf/u+8OWFUyXTc9+gS
         0PFrMEfYGEEDY5FAXKl0G6u/b7UC/atL+8kR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726755715; x=1727360515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMMz1PNX68fmg9+skh8c5Nu7ndZ0JGeQo3cBldmTxJE=;
        b=XWGDMVyH8YHRIt+MTfhCZO6mptknD17AJ4WSpnDnvtK4Qp2LCElPDHVc38CJ1e/BjR
         uuKo3Jsr3DpQiFkZmmJaM/8gXbMlgYtVXo9w9aX82pMaCjL2CPrtTNv965Wxd+fWuuj2
         tA5ayQ0zqcJu+NQE3bN0h02qjDrHJm1aqy5mlKT5suPCoycTWYp3rhciiEEe7XcJgeaR
         9aXWWJm+HZzbhyoBEg/947rtl2a59Q8Ou4CO0ahvttzFFPWiik0iytJoM8Sc+H0MazZ2
         vemB3DQnETuwpTxHPfqSYmGth26Bd4CaHSLaPRoOFwxpPXQsbPOyXdNr6ofqYChRUpIx
         tLmw==
X-Forwarded-Encrypted: i=1; AJvYcCVaMwso+JoRZ1YjHYN7pzjnFRvVS3f4fAg2j6AMM/oVCIaE+JKz7siQGL63qiRVsodPOwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN0H9Dav+FEEus3SCT+1T1J0Q5akTz46KSqDBMl+D6Iq5rj770
	SIyReaPWIzYgI5/J6lxbiDXwMwuwm7e7X7i5CB3TbFLJwn+ysz6lNCrIvFUcZEChvt6zDIX877+
	nelpTTg==
X-Google-Smtp-Source: AGHT+IE26KFokyBPTXnjXKK6tse/DhTftQyNyZam1woc0k+bFuKr+6acFncQ7oeOOyIMzqWCwjJyxA==
X-Received: by 2002:a05:6512:334d:b0:536:a7e0:131a with SMTP id 2adb3069b0e04-536a7e01528mr1436222e87.26.1726755714799;
        Thu, 19 Sep 2024 07:21:54 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870966dfsm1833388e87.156.2024.09.19.07.21.53
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 07:21:54 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f74e613a10so13059291fa.1
        for <rcu@vger.kernel.org>; Thu, 19 Sep 2024 07:21:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3m8X1kL9TSiiOFVpisUm/zdlObUUx53bCTR43/gRKn6U1ePcNakz8PKcAnhPz2qwr5bg=@vger.kernel.org
X-Received: by 2002:a05:651c:543:b0:2ef:17ee:62a2 with SMTP id
 38308e7fff4ca-2f791906358mr165636051fa.14.1726755713557; Thu, 19 Sep 2024
 07:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917143402.930114-1-boqun.feng@gmail.com> <CAHk-=wi76E2xxvOaZtgN2FK9YKmbK1ru_1atL8eBCs34z7UigA@mail.gmail.com>
 <Zuwx409kgivi1G5T@infradead.org>
In-Reply-To: <Zuwx409kgivi1G5T@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 16:21:36 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgLrENN2JFZf8j9TDXcfmnZ8BNU_u=6QrEOti-s6aMrbg@mail.gmail.com>
Message-ID: <CAHk-=wgLrENN2JFZf8j9TDXcfmnZ8BNU_u=6QrEOti-s6aMrbg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Add hazard pointers to kernel
To: Christoph Hellwig <hch@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	linux-mm@kvack.org, lkmm@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 16:15, Christoph Hellwig <hch@infradead.org> wrote:
>
> Agreed.  From the description this would seem like a good fit for
> q_usage_counter in the block layer, which currently makes creative use
> of percpu counters.

Yes, if this actually could simplify code that currently used percpu
counters, that might be lovely.

The percpu counters often perform very well, but then have huge pain
in either managing the percpu allocation, or in trying to synchronize
across CPU's.

I'd be a lot more interested in "we can fix complex code" than in "we
have crappy code in bad subsystems where we can hide the performance
impact of the subsystem not having been done right".

               Linus

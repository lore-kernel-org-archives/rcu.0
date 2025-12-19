Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA713FEE
	for <rcu@vger.kernel.org>; Fri, 19 Dec 2025 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766105027; cv=none; b=MKJpkTPiX142K0iuoJpwOmX0iprXzSJ8QrXiunHaYyqGwJfU7aCROWLAkW0nFnwM9LoHTwylCMhqvrWzOPledSo1Hs/LdAuIqooSDQ89pBPZWZeNgoJgP+eyLDg93pA+2KaqgEFEp4ERTkn/JzhJzr/kyGP5/tYhq56mVdE8LX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766105027; c=relaxed/simple;
	bh=GpxK1aDfEJaB8fwidbucD/6IJwrflKCJ83SIxuIm+es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m939Iw/Bm1FvIBwSrPjw3pIDwbFQA/gi/tMQfrI4kCR+7Gx72IgCy81LEdFD4Mymc2cbgBgzjfsNd9HV8SoMypxlW7qH79TRhF0xUz/H5hQBLE3ZMTUOj9a31rv9nnQwwinvuSERAhyJ9GTwxzC/BVAzKZDdIlt9k3o8JMnQuDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HX/ZWdqA; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX/ZWdqA"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2d56eaaceso149083085a.0
        for <rcu@vger.kernel.org>; Thu, 18 Dec 2025 16:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766105025; x=1766709825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5yXQjeYJcUm9npCVl/WQPVGb/ZOj4espvLUprKL8vc=;
        b=HX/ZWdqAuhg3UuHDrHa8igCqqohC7pZ1+BlyYwizycAgO2wWLXuSrO+NWjf4GJv9nv
         w2jkvfGfHSwCilrORYv9Aja6K8xWzIc9d+SPGgsPS8naaL/lCBCpwfnX/pRWiV9LWJqu
         QSe1E6RsyMwd85iqsNI/7hYePlvGK8yMPyvjPnOYE+3zLSjDk2aGnYXiRl7q5xSCajWm
         jGdT2Wc7XoafLgwuKYOsmmwyDTVVmVaIr4UDMfHpm/BgG7qO9FYFSDbXIf/rHJHxL2BA
         obllRPERn1H2bS7pjVL0cVCEF35DzxW5G4PcbVi4bGnpJ+ijKASBvmtdRYA4Bk7xj5S5
         qVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766105025; x=1766709825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u5yXQjeYJcUm9npCVl/WQPVGb/ZOj4espvLUprKL8vc=;
        b=MXMePM7Ia87vp/3TQZCjRH01jSStjtFjs0814guF/oSdBbdiNc3yFBA0yaBYwjxSDE
         Hzsf6XLQwvZpyFfSKrWXMDpSbPbAG1UpPS4VHRpoStE+suQiCtwwZfujUREL6tbc381w
         sUXpxq3HWPoHcbPLp2Bzo6XwUQHFV9t9vtaEiHriZ6B5CXTcGNeW/Z/XnndZNrZ45v9v
         FsrUqaSIb6Ekq1Rgf8+1VHhrEskoQDsE4U+qXVo4KeOLP7tJw4oDuj5kRiZZA5iViP8Q
         2YoqODHyC5DqvqFIYsrgezekfoHtZqX4Ko4YK9F0d0UJIXr1Mvi6ogI5l286wZ0EdShp
         FcQA==
X-Forwarded-Encrypted: i=1; AJvYcCUEAgLc2ATvAefSVnQ3e8XKqRPy0CN06DzbxyJEWkcEXLmjcGvYZZIm7zFi0p3kVXnjLZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ4FHPnqBm4UEypl2lQhpguS9wHQUUaRxppYdR8D6OdgGel8Ps
	PyXp1S8n0169gBpEM8Yla8Cbb4P1GyeT6QeJBoCmIkZHNX5/6Npnn2G+
X-Gm-Gg: AY/fxX4fme/aIAo9eIj7bayrSv89xR3wNsFr/F58al55P9oARSMiR/u/7YTkbIrCfRA
	gEg6qEUOO7qJsUUSnE/+YfJoKOFPDgwkTaJOG6ofb6pcOcUQALO3xpKLibyRo+z6RE9Xk0FcYLu
	J0CGCQ5yF8gzQ0G5s0YztS04RSahe/Z8pWLO1Zk3MfOC2qcMojtV4h2601G6Qpf2Kdzi0rIJJ37
	jAQ+BAnnN1QpZT7Sx4sFgr1w4RHW0G+oFA3l46UCvBEvTph5tADpFTFzkwem5nxC5YZXjrCIt/U
	nfJMyAo3cjj5aV1fbgetYjaUX6+6YA5WAnMBUpMAqBRAmJLKBJO8gXRoBC8CPbKyNfm/WY1q7gp
	zbF4MiRLl2VkugVyXDEdo23/1oeHISw/Tj2TP8HkMsIHXuEABr/8YNr6zcMc4EM+yFLJ/609T5H
	JNcJXYySV7npDl9KXEMnY3ELxVl6dEob+4OZ+BjFYPveTdAonszrlZaD7k0EWSSrdUcg+ffMnXx
	nW/9y9MYIsiX2cz4B6FKQpj7w==
X-Google-Smtp-Source: AGHT+IFay41fv8PMLFKhbM9Xqksn5yPJ44K9INTfADwIXSsxeUXdkXezhYJ/sTAO68xxPH9wqKC0og==
X-Received: by 2002:a05:620a:191c:b0:8a1:ca96:5d39 with SMTP id af79cd13be357-8c08fabda51mr230657285a.59.1766105024843;
        Thu, 18 Dec 2025 16:43:44 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096783662sm67864185a.5.2025.12.18.16.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 16:43:44 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id BF7F9F40075;
	Thu, 18 Dec 2025 19:43:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 18 Dec 2025 19:43:43 -0500
X-ME-Sender: <xms:v59EaeAftY8boR_LXQwkjYXG75LZuTP6aK7OJzQPjgu0cTzBMjQaSg>
    <xme:v59EaVrotpcsAo6Q92mmtVinEj-wxAuodYi7C0dLXtpLaeDPDBZcScWbaboCR4-UH
    fJLQ9RfurryVUxVSjtkVKdPneGwlreQ5hbEli3-9YyE3uupKnNlgA>
X-ME-Received: <xmr:v59EaSCyCsvr-vOaynLld1YCxXWgcxeqgFGEEN3q9A2sKhe5i8r1qakbDW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegieeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeeffedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhmpd
    hrtghpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthht
    ohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhpihhgghhi
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurd
    gruhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhigidruggvpdhrtghpth
    htohepfihilhhlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:v59EadwY8KDN4BqKdqkPGjxdmzPm2xP75Cd6JnjBeVbBDGbUMI7Xgg>
    <xmx:v59Eaa74_zwyFapcMAazBtoO36hiztMsW0ymuG_x4dsq9WDsY-8h2w>
    <xmx:v59EaevHCeZW17ybOQqxbPIzNIxvUw6PkUNMH4WwUTMGoIcp6BNhWQ>
    <xmx:v59EaXsNk6QvIuZnQUiPMaHyRDhPRvbMr79LrZj_UbhZUPztfY8O_g>
    <xmx:v59EaWv3BFKQ45zgyfitJutqnFrYmD4ojS-u9-hgcEWFdlTO9y0E8JqE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 19:43:42 -0500 (EST)
Date: Fri, 19 Dec 2025 09:43:39 +0900
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,	linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,	Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Vlastimil Babka <vbabka@suse.cz>,
 maged.michael@gmail.com,	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,	rcu@vger.kernel.org,
 linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH v4 3/4] hazptr: Implement Hazard Pointers
Message-ID: <aUSfu4V9mrD7BQGl@tardis-2.local>
References: <20251218014531.3793471-1-mathieu.desnoyers@efficios.com>
 <20251218014531.3793471-4-mathieu.desnoyers@efficios.com>
 <aUO9KRaP0FXpm_l9@tardis-2.local>
 <fcbc99d0-b7c7-45f7-9cf8-f5d3bfad966e@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcbc99d0-b7c7-45f7-9cf8-f5d3bfad966e@efficios.com>

On Thu, Dec 18, 2025 at 12:35:18PM -0500, Mathieu Desnoyers wrote:
[...]
> > Could you utilize this[1] to see a
> > comparison of the reader-side performance against RCU/SRCU?
> 
> Good point ! Let's see.
> 
> On a AMD 2x EPYC 9654 96-Core Processor with 192 cores,
> hyperthreading disabled,
> CONFIG_PREEMPT=y,
> CONFIG_PREEMPT_RCU=y,
> CONFIG_PREEMPT_HAZPTR=y.
> 
> scale_type                 ns
> -----------------------
> hazptr-smp-mb             13.1   <- this implementation
> hazptr-barrier            11.5   <- replace smp_mb() on acquire with barrier(), requires IPIs on synchronize.
> hazptr-smp-mb-hlist       12.7   <- replace per-task hp context and per-cpu overflow lists by hlist.
> rcu                       17.0

Hmm.. now looking back, how is it possible that hazptr is faster than
RCU on the reader-side? Because a grace period was happening and
triggered rcu_read_unlock_special()? This is actualy more interesting.

Regards,
Boqun

> srcu                      20.0
> srcu-fast                  1.5
> rcu-tasks                  0.0
> rcu-trace                  1.7
> refcnt                  1148.0
> rwlock                  1190.0
> rwsem                   4199.3
> lock                   41070.6
> lock-irq               46176.3
> acqrel                     1.1
> 
> So only srcu-fast, rcu-tasks, rcu-trace and a plain acqrel
> appear to beat hazptr read-side performance.
> 
> [...]
> 
[...]

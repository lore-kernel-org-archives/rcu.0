Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FADA1401C
	for <rcu@vger.kernel.org>; Tue, 28 May 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891026; cv=none; b=krTPnuksqAgV7djLzuXQ093wD/WWuqKep3z0s6ficAluewDZqvamDC7Xa2rKvJwsu0aJNw+/fL2DbBwocYoh+Ll8TpueASUUaDsToQ5F5CAr8O48AxGKhKA04EagrB28hGg9/kYQi+4vWT3Wm8VKT2r4ClVy+ZwH1I28onB6UCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891026; c=relaxed/simple;
	bh=KEyBvNv3y5FXKnuQWWl8Z+2elYl7IvopwqOdihU2JBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NufHtVr+Z35+YGn95QnurH3P52LOAmK6pcqdExvnYY+SFi3uaPScvtKa9pOQZdlGlAL2etVMEBPxTF2TCjtzapn0eFQMu/lwp31/Czq3Xo6+ZsHBRvZfX4vHeMS2ChIu4Z1y0Wy4UeXiwDHWUEut+PKs+XU93sm7NpWJRRAWuAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MX5cFsM8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MX5cFsM8"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5766cd9ca1bso856027a12.0
        for <rcu@vger.kernel.org>; Tue, 28 May 2024 03:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716891022; x=1717495822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d0aISgCh4COJAaNSxf9GiLx9gPfwSU3DX1Gqw14Y4kY=;
        b=MX5cFsM8DAz5xhcou82Su3v5uCrIK3Hpz0uhevuE2hvh9zGo6G6cgCCvAwUqArhhIz
         GFNEnstvr1iLKdfD/EIp0HrVi1zN8DaLgj8KERytuoP9hqVW8cZ5sWp/ELW7Xo3v60+I
         +oiR7QuZDvpplTCv36Igw2thrlrePtTDolmYUOqYuSVvi/Em6i2H6dXsga5O11xGZD1w
         drqdpRrUPvKE9+rJvIQtTHxNE413KHuPfz5kkOs7ZacgSamgaztaI+lwKfrr+Ile0ECY
         soRru54GQ4KyNToaB6QHRE5F6laZhuYnLvAVwR/g4XOnZAC9P4LB8xlIfYro70+Z2vbn
         lMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716891022; x=1717495822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0aISgCh4COJAaNSxf9GiLx9gPfwSU3DX1Gqw14Y4kY=;
        b=qoMnvezO1aJH7g2xcwTkAe0/8mmeR+/eqrxNUMJFyrFr/AqBUzBY0aLdIRqXjSgUMc
         VZpiKFZk/W8kLfhq5ZWls3EwYFBqJj+x8LEXwrifY6KsLAWFbFJkxmhBDmvQDblcB8wl
         +7SQT2gZYOGQQYlxOcXyUK1MJd2nl0eb7+LhTqF5V8bya6Ouqle4JdFGJZkAVjetJ1xA
         xqPl6VJLmqSYkxheVSbZg+W10ntKUMAkB+s1LVHlzPXlCnXScgin8kdETPolAe8h9aTf
         SpdaxQloCc1o/n9KATrny+vpbD0vWC4zjk/fhRqZ13QATAH3o5KpY2lPMXbLTRVjXAGv
         IZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGYL1N7Cp9qb4zxYPQQaaceKW3b3rQY/Bn+ii8hYGfVI4SdaJH/ps+vTrfOHN1062MWTVs9xJkcHFs7LA3k98h75Xk
X-Gm-Message-State: AOJu0YzwnOHCFyQhq2MXbHZX314DXsXkhetNAbsyALnvbkLO3wSMKzj/
	+6Rwdv/9RhvSRj/sT+ZP8y6YUgnMEPqW6PQKgvM5ffkI+u5mb++uIGgJ1+7LuOA=
X-Google-Smtp-Source: AGHT+IGpgS+uwKuH2Bpx+dmo3enX8lwr6VN0F4YXbxpz7rHlyHJJKgB6YVNlH7G8nqLwYOL9zLGHxQ==
X-Received: by 2002:a50:8d1a:0:b0:579:cd46:cbfd with SMTP id 4fb4d7f45d1cf-579cd46cce8mr3527712a12.18.1716891022496;
        Tue, 28 May 2024 03:10:22 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578524bbb5dsm7015666a12.95.2024.05.28.03.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 03:10:22 -0700 (PDT)
Date: Tue, 28 May 2024 12:10:20 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Fabio Estevam <festevam@denx.de>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uros Bizjak <ubizjak@gmail.com>, Lukas Wunner <lukas@wunner.de>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Ingo Molnar <mingo@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH printk v6 00/30] wire up write_atomic() printing
Message-ID: <ZlWtjOGNwFIgGYdt@pathway.suse.cz>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>

On Mon 2024-05-27 08:43:19, John Ogness wrote:
> Hi,
> 
> This is v6 of a series to wire up the nbcon consoles so that
> they actually perform printing using their write_atomic()
> callback. v5 is here [0]. For information about the motivation
> of the atomic consoles, please read the cover letter of v1 [1].
> 
> The main focus of this series:
> 
> - For nbcon consoles, always call write_atomic() directly from
>   printk() caller context for the panic CPU.
> 
> - For nbcon consoles, call write_atomic() when unlocking the
>   console lock.
> 
> - Only perform the console lock/unlock dance if legacy or boot
>   consoles are registered.
> 
> - For legacy consoles, if nbcon consoles are registered, do not
>   attempt to print from printk() caller context for the panic
>   CPU until nbcon consoles have had a chance to print the most
>   significant messages.
> 
> - Mark emergency sections. In these sections printk() calls
>   will only store the messages. Upon exiting the emergency
>   section, nbcon consoles are flushed directly. If legacy
>   consoles cannot be flushed safely, an irq_work is triggered
>   to do the legacy console flushing.
> 
> This series does _not_ include threaded printing or nbcon
> drivers. Those features will be added in separate follow-up
> series.
> 
> Note: With this series, a system with _only_ nbcon consoles
>       registered will not perform console printing unless the
>       console lock or nbcon port lock are used or on panic.
>       This is on purpose. When nbcon kthreads are introduced,
>       they will fill the gaps.

The series seems to be ready for linux-next from my POV.

I am going to push it there so that we get as much testing
as possible before the next merge window.

Best Regards,
Petr

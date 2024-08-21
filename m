Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A227B1E8629
	for <rcu@vger.kernel.org>; Wed, 21 Aug 2024 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232108; cv=none; b=ftFO5WGMUbm2ZZMtkUBIW/8fgC2F17nJeCw8hX203KERl9+Hu+O9F9aOGPYJ4s4eYewXNZsk+oz7gh9bD/1cWhIEh0xXKcZyEshXRLlSaRpuBFnjLDsbMWVA2FALpOqvyuMsz47/BW0INOk56v5NGfUBf6fKXZY3sl8QB6Q0dSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232108; c=relaxed/simple;
	bh=zTrmrwvcnsUQONnVX7bXvpZTK4JkDDsBtO5iwajA6aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8Co19B43f+fcIL6ZlOUEmM+uuJH2UXVoj4//QD1xETPK9hjL1QfIQmiGvgWPjlgfAza+1e3Q193skxI/pMju4oizxocDr0uCvcHBMcYGi+uAr00LHV4ywFYIEZ4ly9xziglR2P7tUv1V9DdIu1Y0hEQYBaWXY4TezAU0MBVe3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gydyfXgW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gydyfXgW"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8374e6a6fbso774424766b.3
        for <rcu@vger.kernel.org>; Wed, 21 Aug 2024 02:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724232105; x=1724836905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mEERTRPjJTEkA5X/eKpaMzz4m2QDKwkJiDLjgwX79HU=;
        b=gydyfXgWCjgdhmXEJ4TLl1S96HDbpmtjq0t8wKUZevFdXl37E7zw8AnxLg4sGZxHDH
         AMBUloEgvdF349cbtZ7EiCweev08Y3cHJBpp8dSV14rBBokqf8O1G+Cawb//jLFxfWEW
         MTjVtg2zl1o+7Y9yqXq1STMBdBH5lBHka5DUo8NLEXy0wP/OKl4z5b1jepWAQG7KF1HV
         gB0PFI5D7RaQELYsPOgmSt12YyL9k4MfpYQvpMFtsZcR1NDe179fz7sx0tZgJ04mKorB
         qwjyFl2ZoxlMM6jK02ucNbXAT+JPgJzjJlUGcknYulfvvIv7+INmntW7Q1Ezhq1lEmWD
         XNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724232105; x=1724836905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEERTRPjJTEkA5X/eKpaMzz4m2QDKwkJiDLjgwX79HU=;
        b=PfjdA2z5xkXbgcHzE1qUZRr1NZc1r/XHSX96Ava9wMZu3lP80LqJ7miIDdLgy9XVwu
         WOQ1PA9w+Etj8JqciXI42epclwBBGDoJi12fUnQvNkYJ4NrJi5ZpcZcVcyu31dOgByFn
         7pj+VFBIoqJAzkMbG3UqmuOigsqGwf0wCBk421pryLuu9IajEsoJS2EowlXHhVCXMRD+
         KxGJ6UVqbtFP+II9yOlrM2ZDBSVl5aUFNMYo+aXFU6uqjNnT0t2/qEcw7s2fGzQx7jgd
         6DB1ws3SIHyKBkCb7UCdq676U5xMQ6RgK/oB1trWx+W+brwuOulcxHh5WEFBaoLb1Pw+
         ZX3g==
X-Forwarded-Encrypted: i=1; AJvYcCUoubKncH9gV7oD+1e9MsS9tg4VF6p0HPLAi7Ex+GrKJju3gkxfraVh0OBUSyTu5VDVA3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1S4kxZDDelqwEHSGTsPTlJgA/HMjpYS5ypCR3tY5j6eOo+ff7
	Bq9EyyMcDeuNr6tZ/DMW8JuOdt6EnrVD2b80qWP9M6miz6umFJ4uKw4Tdxo3+Bw=
X-Google-Smtp-Source: AGHT+IHTKefgAMslcV1Cs0upS9eDIaDmi87CvvZ8H7V6d6k0M6zSoNhCt8tI49NL7kOCx/S0LuujdA==
X-Received: by 2002:a17:906:bc27:b0:a7a:ab1a:2d65 with SMTP id a640c23a62f3a-a866f9c83f1mr128643166b.67.1724232104806;
        Wed, 21 Aug 2024 02:21:44 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383946898sm881723966b.174.2024.08.21.02.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:21:44 -0700 (PDT)
Date: Wed, 21 Aug 2024 11:21:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Ryo Takakura <takakura@valinux.co.jp>,
	Uros Bizjak <ubizjak@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	Lukas Wunner <lukas@wunner.de>, Feng Tang <feng.tang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH printk v8 00/35] wire up write_atomic() printing
Message-ID: <ZsWxpVG8uZ9Nq26h@pathway.suse.cz>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>

On Tue 2024-08-20 08:35:26, John Ogness wrote:
> Hi,
> 
> This is v8 of a series to wire up the nbcon consoles so that
> they actually perform printing using their write_atomic()
> callback. v7 is here [0]. For information about the motivation
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
> - Mark emergency sections. In these sections, every printk()
>   call will attempt to directly flush to the consoles using the
>   EMERGENCY priority.
> 
> This series does _not_ include threaded printing or nbcon
> drivers. Those features will be added in separate follow-up
> series.

The series seems to be ready for linux-next from my POV.

I am going to push it there once I get approval from John about
the proposed update of the commit message for the 30th patch,
see https://lore.kernel.org/r/ZsWvRETyuh1Yq80j@pathway.suse.cz

Best Regards,
Petr

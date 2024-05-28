Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CDC16132E
	for <rcu@vger.kernel.org>; Tue, 28 May 2024 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903366; cv=none; b=jmA0LW8/PCD3+/iaFeptm/snb8fwMZPtWZhq7VE/F0hISl90/aPIc7SbMh234MjHzeRftLLbH9k1X9VyQVjlZ/0f4gzjKpVLiwAXMljHfVERzzR0ETNgnsfAm69DiJC8i5+46lW6d/h9i0EaMQzAMmWebJc7gRx8P/QaweFI+i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903366; c=relaxed/simple;
	bh=JWtHlmtusIhLMWgbZyZG5cDMUrRubiSJG0EqXMgnYnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVZL0aUnDWQfGLBqun49Uyim5saUpFxNv6oIkXyS2L9CWtFzKAWGt7WC0crw67i16v++Dvv6HYwN3nEJWeBriy+soUr0vKVfyF6RYPkjnIVDOExmfFu9eLwLzgRm4KtKlMt4arE3cgQ4Hw7bgPwfs+EySWLQkxmIxFbetPIFuuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TqJdRyXC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TqJdRyXC"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6266ffdba8so82616266b.1
        for <rcu@vger.kernel.org>; Tue, 28 May 2024 06:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716903360; x=1717508160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tW6M0gf7saQEvTU4yjSGcUXDr2NTy1Qf8dzKr23/MaQ=;
        b=TqJdRyXCTQpLGFNp/a470s5Gco0RCyVozVHwMyhUMiLZ8jYHncwPd9lzibOxmiG4Xf
         qleLq70gWLOrJ7NP5YZUGZrqF4lEDOMZ79ypKp5K/eb+EGtCiU33Kytj0qWtGBVzO03j
         whGYmjgppxHni7cy7Np3RULbdSj7+I/HowltPo7a19TWe8V3aMX23BVPSP0CiN6UiyuA
         htVjIYrHa1dFLYFeqUpkN2grMK9VxCUaqWp9GcGVYVvPrbm9I/fJbFkn4p2UnRlKfrsr
         uD332eE9qEYeSgUOyYJ6lLFt46mUnZ6imZ2tzjLApz40h2HZ+TFFa3zSnZiknpceHs6K
         gtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716903360; x=1717508160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tW6M0gf7saQEvTU4yjSGcUXDr2NTy1Qf8dzKr23/MaQ=;
        b=DQDbUjTwXaBv5Q3NMCGjRP7YSApOlvv3KeFkPyL0OM4WZaY4WA/ZeOX5nCIpC8Cbgv
         NZNSZN/tzFEmBxPQdcj/EXi971snQoXNDdljNbCTKDYPruBczA3GtJooCa1p3juc6WFU
         cmDnn9CBlOsHVLrmhGh0hTXR0WM3QQ8ib/HzTK80IOzPH3S+vAnEjNeN+Qgn23ZtI5NX
         NZmS71HhOVhEm0g7GKPZtHiyZvfqNpacfkaFzVWGbmGEazEdRr9VHu83VnxhLaN8dog/
         96DPDmxOBYnbW062ENophLshewmah8CoEXw+JTPLR5PNIbjTrrLRiaC/AN57jLOKsN1i
         YhCw==
X-Forwarded-Encrypted: i=1; AJvYcCWLn/+8rjkgF52ViiTt5QmNaSbb6csQEnCqQyP/Yc7c5d/Ds0CZ183nqxY0JpiczzoMRPstPddq6oUZU819tg4y9gdR
X-Gm-Message-State: AOJu0YwVmN6sl8UKyNMpwE+792IC8sSPkA04g1DUu5iXs4xEwB82XQr9
	82njmRWeJplNvLT8XkylL/ood7iKyGAmznl32thZdhldaugfYf3EgFF8DfEGJ4U=
X-Google-Smtp-Source: AGHT+IEumiJvLe2iqeJZzK+4O+ttaD5gz/XEAjpw+T/85TMemHOvDBJLGV9W/n6Jlf8pqRiBNEKqLg==
X-Received: by 2002:a17:906:2789:b0:a59:9ad2:a7f8 with SMTP id a640c23a62f3a-a626511490fmr837850666b.72.1716903359901;
        Tue, 28 May 2024 06:35:59 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc514e5sm616549866b.103.2024.05.28.06.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:35:59 -0700 (PDT)
Date: Tue, 28 May 2024 15:35:57 +0200
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
Message-ID: <ZlXdvVO2jA55Ow-B@pathway.suse.cz>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
 <ZlWtjOGNwFIgGYdt@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlWtjOGNwFIgGYdt@pathway.suse.cz>

On Tue 2024-05-28 12:10:22, Petr Mladek wrote:
> On Mon 2024-05-27 08:43:19, John Ogness wrote:
> > Hi,
> > 
> > This is v6 of a series to wire up the nbcon consoles so that
> > they actually perform printing using their write_atomic()
> > callback. v5 is here [0]. For information about the motivation
> > of the atomic consoles, please read the cover letter of v1 [1].
> > 
> > The main focus of this series:
> > 
> > - For nbcon consoles, always call write_atomic() directly from
> >   printk() caller context for the panic CPU.
> > 
> > - For nbcon consoles, call write_atomic() when unlocking the
> >   console lock.
> > 
> > - Only perform the console lock/unlock dance if legacy or boot
> >   consoles are registered.
> > 
> > - For legacy consoles, if nbcon consoles are registered, do not
> >   attempt to print from printk() caller context for the panic
> >   CPU until nbcon consoles have had a chance to print the most
> >   significant messages.
> > 
> > - Mark emergency sections. In these sections printk() calls
> >   will only store the messages. Upon exiting the emergency
> >   section, nbcon consoles are flushed directly. If legacy
> >   consoles cannot be flushed safely, an irq_work is triggered
> >   to do the legacy console flushing.
> > 
> > This series does _not_ include threaded printing or nbcon
> > drivers. Those features will be added in separate follow-up
> > series.
> > 
> > Note: With this series, a system with _only_ nbcon consoles
> >       registered will not perform console printing unless the
> >       console lock or nbcon port lock are used or on panic.
> >       This is on purpose. When nbcon kthreads are introduced,
> >       they will fill the gaps.
> 
> The series seems to be ready for linux-next from my POV.
> 
> I am going to push it there so that we get as much testing
> as possible before the next merge window.

JFYI, the patchset has been committed into printk/linux.git,
branch rework/write-atomic.

Best Regards,
Petr

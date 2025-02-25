Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B4826159E;
	Tue, 25 Feb 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480878; cv=none; b=WLDg0R2N5mStLq9Rxqkk6DwWx18yvX+sFv4SlA8qUlRgOW9nrc2D707A8VWStzH6oFho7S9605vXQryAW4lmbn10Z0I3knGJKkPeQzpg7oRYoKzp4soFdkdAkHvL8UoF2Nl+ZWEG3Ceov/NNKxPFiJUTKb3recvR7BP8tfDYMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480878; c=relaxed/simple;
	bh=Ryw5sYWXbkK04L+veV0uDVkXTR+HOBKPnotAxN+8LKM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkhNA93vQ+CThZtY/0DZ03CcuNwaqKltQZYfXIoDd7suxGu76xDoYeJJiMrXW2W39gvVuALrB6aUjugwhhNOc1BB7RYVy53bm6zPDpwDU1dDeVOmF1eX4G6bplWhmu2rq3nJaxfzcXLn0y1tB8x9t3oxvnvCmz30U/+Uf4ul0zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9LZvC3e; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9LZvC3e"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5462ea9691cso6069810e87.2;
        Tue, 25 Feb 2025 02:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740480875; x=1741085675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6HmNB9ABLLVuzaRgxVevCveVvbZ+G7bGWQTYZ55Pp10=;
        b=B9LZvC3eSkppF42G0QqXwoPHCyyTG/7XR1nTu3M8BcLPxj0T1eA5OXExHu3F0o1Zf+
         jZcVHYD432tXfrBBWaUFKD9jFe7MDxu+ddniviKV2shSFhUqzZuGuKugsKorYghxFdt9
         9r648lz92SLvmRFpEcADyHVP9Fgex3EWUxnp6XMSe/3kQo1AsIYKP6iDTbaIm0EZ0Czt
         cLD0UXhoDbpeQiAbJnuwXmLrUd8NKJXCNTWiYtltt4WZCwJWXKxhs1Dfw3BntnV6eJBa
         DClToPbbQjntKUPg4nfuu3Yxitt8p18A8d84PrFHNyygsNCHvwkSAah65tjJ+fEz6znz
         mWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740480875; x=1741085675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HmNB9ABLLVuzaRgxVevCveVvbZ+G7bGWQTYZ55Pp10=;
        b=fIj5vCOoWzA6tTHGZTCiQkd1b7/1CccyV8HfuUI/rNX+uvoM67BwWkHybF9Z6JzsbN
         fRhUpXcT5LDlbS1SBU5nejhX8eM+YQagH/2uVK+o+BPSBxRqPSYDQrB/u34X3gos0fK8
         BpqDhsjqSADTYmLmd5uBcS9BHSVO2OOpxx/Kw1HZfEfQMXsgodlvvx4NQNy97Y0M9WBX
         jHS4LDL4OyWfeOEfTkCcbcFQ+py7SZYiIP1ioLDJlKMaUQPvVnC/lBYtYObLUBc6MhFo
         C/Gim3PO7hIk2F8CtawWZ35c7ONuME0bvilvUSLeZi27UdDrGMK/7nNVguoqwCsAQtAa
         pd4w==
X-Forwarded-Encrypted: i=1; AJvYcCV07LX1vE3P//ObjFxgkNrx6X8XeXux2AFpdrRZJqLBKI2Pv5mwhZRwcGNTjfRCmzbBf8bVmhTSmuyqd9Y=@vger.kernel.org, AJvYcCXjzhcWtKvN4CrHJMZpvSWusIyXlSqsaZHvVDOjpOcZ43h8j8R/EjCA95JcYfsI8yxW22vJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzMqX7vx3OQ7klovRrxDk0539C4Fs9Jv0v8lTSbL1/8uaPJorli
	+5rDPCViONKZW87Fw7FItWJe461NYTSxssmMOyEwOUVKQqQcQMB1
X-Gm-Gg: ASbGnctFJe3DflnMUxsIZsCa/bsEp3y5O7UljKTHRUf+HqEKax6LsS6vdvWHDoLNv4c
	OPiAn3fx+UqqpnWEGCS9RHOlf5AED0xm1nqP9avuUwcwSJArrU90uqWoKzHEg2cF3CFMM77gBKy
	f7OIWRbzAzJ8Yvt2kCupLivuTyUWDlMqkxoheKTrxoPe9Cm9s+K4+r4fzUJZHTKYyHJGYzq+FdW
	M9af1iM5Hz6XSCnTPc475jKu3j/oN001yptW1Nd6b5mzUB7plqcsyjXx3VA2yFdk2OGtz3yODXJ
	Qk08W9qqyaJToSgIsFhtCVbaQl0XkVnvmBmXPpSZfsKhGEVK
X-Google-Smtp-Source: AGHT+IHbf1GN3aLXGe750miHH5cSw0ry0Jfv/g1QUOwLirt+MK7do97DgegC4mqwqEBSqwrhoALthg==
X-Received: by 2002:a05:6512:118d:b0:545:5be:a6b5 with SMTP id 2adb3069b0e04-54838f5e166mr7481272e87.49.1740480874476;
        Tue, 25 Feb 2025 02:54:34 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b2370sm147561e87.35.2025.02.25.02.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:54:33 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 25 Feb 2025 11:54:30 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z72hZg323iI3P8B4@pc636>
References: <20250224133659.879074-1-urezki@gmail.com>
 <20250224133659.879074-3-urezki@gmail.com>
 <400c9d5c-8725-4723-b129-c5f2976817a9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400c9d5c-8725-4723-b129-c5f2976817a9@paulmck-laptop>

On Mon, Feb 24, 2025 at 11:06:01AM -0800, Paul E. McKenney wrote:
> On Mon, Feb 24, 2025 at 02:36:59PM +0100, Uladzislau Rezki (Sony) wrote:
> > Switch for using of get_state_synchronize_rcu_full() and
> > poll_state_synchronize_rcu_full() pair for debug a normal
> > synchronize_rcu() call.
> > 
> > Just using "not" full APIs to identify if a grace period
> > is passed or not might lead to a false kernel splat.
> > 
> > Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
> > Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> > Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  include/linux/rcupdate_wait.h | 4 ++++
> >  kernel/rcu/tree.c             | 8 +++-----
> >  2 files changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
> > index f9bed3d3f78d..a16fc2a9a7d7 100644
> > --- a/include/linux/rcupdate_wait.h
> > +++ b/include/linux/rcupdate_wait.h
> > @@ -16,6 +16,10 @@
> >  struct rcu_synchronize {
> >  	struct rcu_head head;
> >  	struct completion completion;
> > +#ifdef CONFIG_PROVE_RCU
> > +	/* This is for testing. */
> > +	struct rcu_gp_oldstate oldstate;
> > +#endif
> 
> This causes the build to fail on TREE01.  One way to make the build
> succeed is to remove the #ifdefs above.  Another way would be to add
> #ifdefs to the WARN_ONCE() below.  I suspect that removing the #ifdefs
> is best, at least until such time as people start passing many tens
> of SRCU instances to synchronize_rcu_mult() or some such (which seems
> quite unlikely).
> 
> Thoughts?
> 
Right, i agree. I will repost this series.

Thank you for checking and testing :)

--
Uladzislau Rezki

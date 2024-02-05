Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDDC1CD05
	for <rcu@vger.kernel.org>; Mon,  5 Feb 2024 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139523; cv=none; b=svGl0NZXFljHjVS2mUkd9256zHd9IiERHPZSs/lfqbGUrmewECgwOGEOcxM3tB+hw2tpB7MwxXXd8vpAAvIdX6i9/Ud6NZceyNtJ89+PREDM4QfujzABHiHgGPfDo41nT7EH+65zhkVBLkpJyQZlgb5fKX1wlIuyUv/Wr/gTEbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139523; c=relaxed/simple;
	bh=t7y7ctIJTyfk9EMxpN0dttuSUEj0t+PKUapgUg8mH0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAcbbIxwOHp+pDYGqUW0mpPHxSFlfqpUx2LH2r3VhfPsuYeHYVUYAsg5HafJjFGjVCU993KJyXWIUbyXUjK5kDfJwU5c5eNbmHsMMVReRL9UvFh7/eoOi3pAtHm3Hgfg3u5wduoUAo5NOzH0L0xCtykT1VyjGVS9cm2bWjBqW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l+EBhT9w; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l+EBhT9w"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d93ddd76adso31374205ad.2
        for <rcu@vger.kernel.org>; Mon, 05 Feb 2024 05:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707139521; x=1707744321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hyaY/CbyAKqBC/FUER+U6n+tr0Mn+KKgrXpLbjIJx7Q=;
        b=l+EBhT9wUlUutCN6YSF+vEJxkpmep4cdvAvON49XQlbfdkZMz074l4E+Jk8qZmvfAX
         C2zA4L8MmLspvsKkNs+PyuKyLrztrNlDLAma0RljZdrebgkW/GaEUmHAa98obbHX3W4O
         1+btjmDRqHy5gTWiSpIFGDeR39gaFSaUEFbec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707139521; x=1707744321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyaY/CbyAKqBC/FUER+U6n+tr0Mn+KKgrXpLbjIJx7Q=;
        b=E/Jvls8bdlnrmwh986HaEuNvMnET8EEOdzq2Qn3Ac9c0Pube30uLivfCPXuIreJ8hj
         GJ51E/LFFisEiXng2HBGwsoq3JalG1genDkQmXBh1Lo5nCX3w0CGfvzou3z/2xbJ6q9l
         etEY11/uYQzK6Ym643/eC/wdG2+Owh04pxg7TVMFdhmJl2e9jFWpwn4m5uSIyzhI5usp
         fcJXAeXSCDMoUBiXdYJ2WGFLk2zzAmm5mU1WSost54blI0fhLIxsfFn1obC7ZiLzArZQ
         xcJSkSSEANVVrjccPU3Gi6DapIEObtJhK5UM+18F+jPl5e5vqCK4RdE/wsQwTRfMy7j+
         A4Mw==
X-Gm-Message-State: AOJu0Yz3+OMXlbXvd7uZ795huk9tVueE3y0U8nMdps4yqe5sM2/aAw5u
	ip5DEfPYdtei5vgOYUvGJ5vNj89biZx+ahobOfd617qbDZg2L4N+vdGlFO6Ing==
X-Google-Smtp-Source: AGHT+IGFcrCxcgo9S70LMmfS6r9SChgoGlSL71MgC0LPypYRVA/T1SEfDYFFeT5J6u9SYgumuVtYTQ==
X-Received: by 2002:a17:90b:3584:b0:296:3cde:98a with SMTP id mm4-20020a17090b358400b002963cde098amr7122887pjb.6.1707139520929;
        Mon, 05 Feb 2024 05:25:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU/W3XODJ1ns8tFpQ7FGZwB5l1IHrgZT4lswGoHO/qAiqjVu5oneq2TDut3Kxi1oxUhCIPhiiCCZi3g0rgyl91SJnGmBphrBaaCgVPG4XnRbAExwMg1pbz8/+HPTpl8uRXDxYSYY13bs7TghqUTwfAWowvt+EYCYcVRi9B8Z0mosNiv7Sg0M0xDJ1CWsATKOPT4jXT5H4qS9f7gEe3Epjkr0lnFNPDJ5GesKRici/2lvphHZe9dwdMrShkx3kDXSEWciijOCI/iiz3IkRFB5fwwBzCLkOeRo8RK5/W2WHTE+llPM01/XJ8XdPdFgWCgHQ8ug2dQBNjc9MKvR7nzMTtEIGzgWMcdk3yf3Q==
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id pb8-20020a17090b3c0800b00296bb0b2f57sm171494pjb.21.2024.02.05.05.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:25:20 -0800 (PST)
Date: Mon, 5 Feb 2024 22:25:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Petr Mladek <pmladek@suse.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
Message-ID: <20240205132515.GF69174@google.com>
References: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
 <c6ce8816-c4ff-4668-8cbb-88285330057d@huaweicloud.com>
 <25fd8537-5a27-4b62-9bf9-1ee7ca59b5b8@paulmck-laptop>
 <Zb0evDquygkDI_8P@slm.duckdns.org>
 <c5d5ad66-da86-447b-8014-820d2c67382d@paulmck-laptop>
 <ZcDdlRzpofn2cAuO@alley>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcDdlRzpofn2cAuO@alley>

On (24/02/05 14:07), Petr Mladek wrote:
> > Good point, if it does recur, I could try it on bare metal.
> 
> Please, me, John, and Sergey know if anyone see this again. I do not
> feel comfortable when there is problem which might make consoles calm.

Agreed.

> Bisection identified this commit:
> 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")

That commit triggered early boot use-after-free (per kasan) on
my system, which probably could derail some things.

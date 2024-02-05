Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3A21BDD6
	for <rcu@vger.kernel.org>; Mon,  5 Feb 2024 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138459; cv=none; b=GYFCxCPk8ztx8i2TOkp5Lnff80sQeTDwuTXsX4h0Or8LT/pPAvOC03xlyiXJSHP6DX0D5tuuW7/7BF4XvnZtBMSCF3eqvv82+Q+/zHvzzuiwpeSBZO84PhQ27dQHVYiGGfCFu2e8LpBofMybhd5iApNTHgGaiBt29CoMBBQy/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138459; c=relaxed/simple;
	bh=8IPgAyBOVlUjnkv8wh+Tm4lw+PMeIONQj8dzU1ytE3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3ZCw3ABk3U9+4/1u9jCKJwVcnmR4Jq32tTTVYmf3DssuneMwQ2pwKjTwSEo20BvJdUEerNkS9BjKimljMVHsnrTCYbcsQO8qQl4qq377PFSN82T1QjvR+O2rcIOjrGokoMrrH6XSVFZwT9yH3i8ysIb2O0Qxq3D8Twh8p2FQ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JICJc5iu; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JICJc5iu"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d094bc2244so24572011fa.1
        for <rcu@vger.kernel.org>; Mon, 05 Feb 2024 05:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707138455; x=1707743255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2QXzXXwRZfKvmUtqjt4P+dHxSnzs9bcTO1bAgWVXXC0=;
        b=JICJc5iux+vDhZDe+F5nTSWNnDwWBL4XfRySup2VdqXmQNnmfkaU4rlSYIcCELTUF/
         lhbnCsqZPTZlh4TYCSg89YVDd+xVLwEeTsRikgQO5kE8/wRUtLVaPTa84ks4Rqa0uAX1
         iJeIqSh/7Z/aOiIjaNqe21icfLyJdXQLK2ITQ3F+fjUbYg/KF266hhKLaDhm5lDblP3m
         AlwzlIOKkNNaCC0v6Kob93OAh0/qSZ8NYhOH06KAChFJFAiTMlCJ+Dks7Wc32TVTOCIg
         Yxlzmrq6mGSdkIB3WVjZTI4PB8pyMWPCnNauWTzvShhmSdDJDLsRVHMZlH59fDlztvCw
         idgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138455; x=1707743255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QXzXXwRZfKvmUtqjt4P+dHxSnzs9bcTO1bAgWVXXC0=;
        b=nCwxcpgfnJjQRVIBoFZ9qlNNzg2xMgTpPxnF/plB7ZipTdcvQqqzIa2oAE4oCoH3K5
         EBiNNcTxan6PNeIBj+X12wpnUX5YecEJUWR/KWX7X/y4lWlDKHGG4ankoNAbQqRUdK4I
         xTrJ9HlrUnyIlMHej5F/KmwnZ81OOrEPu7NJntzKmOnAWoRw5BQiQ+xJZ1tTFTV4aqJL
         y1hGxW3aK056ANjCTG6ck+4RGhboPspSWLMZNDF7ATnk954yYrTtEWnAwQwzpSiiW/Ef
         HL6vB4q4Rrf4R9pCa5ohHDCubRN6EcQ11hTAoLdxwj6IdOPhVpHy9XHcPz9UNUTSnsIW
         7+Bg==
X-Gm-Message-State: AOJu0YyqW9WKbC4Z5m311Ya1h7Wqm0KBHQ6nwWPCYf02BhXeFh5BerE7
	GzD5cdAgJuj5ACmes3P6GAiiBdqKgFxInYJtPJvUKbmAX276jGq6Pmdb9kZiu+A=
X-Google-Smtp-Source: AGHT+IEcLotDGIjm/kaJeJMJ8VntOQLtpRdpfPe+Jsve8SNyEZkjXViB/veEPUmLh8Rh3z40K+VdBQ==
X-Received: by 2002:a2e:9081:0:b0:2cd:1366:4aa9 with SMTP id l1-20020a2e9081000000b002cd13664aa9mr5752768ljg.25.1707138455398;
        Mon, 05 Feb 2024 05:07:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUcbVCMXiuGEVBvNpiKwsOgnfIlxdtU0yH+3bKYd8NAqpexK7JwzXttmuGtRjsOSKMiYo1ZQmIU8WlRIZdEFwvTO4if4cclWvQrf0blwafgWvY0Ra8GQqTAETy0kJjOQJtlEIqc2OEecuBmQBxHplBaO+yyToyewE9PT6mBNnK/p83v2fKbPwvLNvkiOmvc/6U3MObMBOq1tlK4gdxLp329/6j2hKYY/TOapQ8WGezvUthkJaY4cS4NogPrQj5541J4HDTRrP6VNJ4QIlst3z0hf+wta7/kfyQDB/5FXVJoX9q210QyqGDoHD7PpI5zRp8ImT241AyCIMzqjw==
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ch17-20020a0564021bd100b0055c8a30152bsm3729106edb.83.2024.02.05.05.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:07:35 -0800 (PST)
Date: Mon, 5 Feb 2024 14:07:33 +0100
From: Petr Mladek <pmladek@suse.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Tejun Heo <tj@kernel.org>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
Message-ID: <ZcDdlRzpofn2cAuO@alley>
References: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
 <c6ce8816-c4ff-4668-8cbb-88285330057d@huaweicloud.com>
 <25fd8537-5a27-4b62-9bf9-1ee7ca59b5b8@paulmck-laptop>
 <Zb0evDquygkDI_8P@slm.duckdns.org>
 <c5d5ad66-da86-447b-8014-820d2c67382d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d5ad66-da86-447b-8014-820d2c67382d@paulmck-laptop>

On Fri 2024-02-02 09:40:05, Paul E. McKenney wrote:
> On Fri, Feb 02, 2024 at 06:56:28AM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > On Fri, Feb 02, 2024 at 08:35:51AM -0800, Paul E. McKenney wrote:
> > > Good point, and if this sort of thing happens frequently, perhaps there
> > > should be an easy way of doing this.  One crude hack that might come
> > > pretty close would be to redefine the barrier() macro to be smp_mb().
> > > 
> > > But as noted earlier, -ENOREPRODUCE on today's -next.  I will try the
> > > next several -next releases.  But if they all get -ENOREPRODUCE, I owe
> > > everyone on CC an apology for having sent this report out before trying
> > > next-20240202.  :-/
> > 
> > I think I saw that problem too but could reproduce it with or without the
> > workqueue changes, so I did the lazy thing "oh well, somebody is gonna fix
> > that" and just tested as-is. It's a bit worrying that ppl don't seem to
> > already know what the culprit is. Hmm... I can't reproduce it anymore
> > either.
> 
> Glad that it is not just me!  I think...  ;-)
> 
> > So, there is some chance that this may really be a subtle breakage. If you
> > ever see it happening again, triggering sysrq-t and capturing the dmesg
> > output (network should still work fine, so these shouldn't be too difficult)
> > may help. sysrq-t has workqueue state dump at the end which should clearly
> > indicate if anything is stalled in workqueue.
> 
> Good point, if it does recur, I could try it on bare metal.

Please, me, John, and Sergey know if anyone see this again. I do not
feel comfortable when there is problem which might make consoles calm.

Well, there is no queued printk change. Also I do not see anything
obvious in the changes added to 6.7 which might cause this behavior.

> > That said, another data point. In my test setup, I use the earlyprintk boot
> > option which enables console output way before than workqueue becomes
> > operational, so having on console output at all is highly unlikely to be
> > indicative of workqueue problem. My memory is hazy but it seems like I can
> > no longer reproduce the problem on the same git commit. Maybe it was a
> > problem on the qemu side?
> 
> It might have been a qemu issue, but I am using the same qemu.

In theory, it might also be caused by a change in the serial console
driver. But I do not see anything obvious there either.

Best Regards,
Petr

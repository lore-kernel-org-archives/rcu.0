Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0598D1A2554;
	Fri, 28 Feb 2025 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767089; cv=none; b=iOHoHSV1Yq81HPYpA58enEXAJzv16td37ThrXhXVo9tr/jAesrGh38ii0Bk4P3z13s8cDyy2kjwQvv+YdhG6z9SlVEjQzBviZjSBiifnl5zAltM4a488KOgo0HFogoWnkG++AUfbFjtwb/PMmS08evd/uxdxAOSolRx4u6Crr4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767089; c=relaxed/simple;
	bh=6m6/xJEhRoLovQPwDvbSbrewcFTAezagTP2uTBBpNRg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMuwmJnSDvisJ8r60EEyVQ0EZYgXK7FIw8L7E+RIsKLMMbtL2Sw5Cw0IZttHU5IvmigUfJ7xX04Nx2IIuKGwlLWDJGKkSBB9C6qvWbBSWyUJ2twonau7pDyc4famGEXmYFGeU3pGphqJnwrHuEpMb4RQMcKqH3EjDPIj9dQ5yII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEl2/9vy; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEl2/9vy"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-548878c6a5aso2603265e87.3;
        Fri, 28 Feb 2025 10:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740767086; x=1741371886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TLGSYkqf02Kp56/0eTJRyl794gQdQOZXD6lBotLGUYA=;
        b=MEl2/9vyJ/Hf32CFpzrE5PuDxNgXP/WGOeGmM9p6qSoEzO1rOAEuUkQPLfqZ5lkq1N
         Ys9xU2YTSW4wBdJWaBN6ru9k2F95CMQTbn1k664O3BxNJmNZ2qjLzgG8MMWDwe2G8sCm
         C5QldAgm508hdoSzUq4c1jLxW8j612yVkGpeCl58Ow665u00nbfq6/YvC2kKq9/XtBHR
         pwn4dfhUoukSv1uF+UmL3dROyZVaylJDOIqjc1+ysHNQF/ymNUYj6/wwczHeAyFmD4AS
         RhbPxFaux8ob6ZVnvdc5ElS+6G2BGvI1QGh8PE7VIgorR+iBC3DPi/+Jhq8kafNLfuPW
         O/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767086; x=1741371886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLGSYkqf02Kp56/0eTJRyl794gQdQOZXD6lBotLGUYA=;
        b=JQh0dGCIMObzyCLFdW0FJIl591eXUqWJXJYUu7Z64fwjBMrVUGzTMHJE5f+C7bD33G
         WWDiM1iu1t253oheSnkcr9FwWzGB5Hgc6EsbtPK2LongLZOB6Sok2A5LLvFWXzASAhBF
         GeM/+NYdYvJmBZ0dviW4u0XOLx3JaPLpPRQYk0ubSRhPd6DxijIe54Oii2al0zMBPrKd
         r35G2Z9eVJCAX+yUABia1B/GZzsxE8Gs+lJRNV7UInyQeDMF5tyhHEi9qjhBMvOMARjp
         NMKRug28QVg43A+d7fe48dRJ1PPLUedB+e6/vCtte05XhkNN/GVgBG+FYdnkOQUkQ35f
         ptJw==
X-Forwarded-Encrypted: i=1; AJvYcCVyRsz8fZGD2/9lZM5raXkZVDVifBDdvygJzO4VighI7miGUOKUovqooHsSYz3fPtatUrAU@vger.kernel.org, AJvYcCWcqTGfl3RhuewMkyH6Hpc0KKEs7jzHlVgPJRAR8FC1ty6Cg0OzVglLPAl+cEEyZ/BbiaCx2WOmjZvq8P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyISTACUhajkO1GG0KJl3WjYieSiQ/EQMf5tbRtMriloi7iBdJM
	TiSUw8sDR8q7ON0K+2NkJblAEVouBTZweDWexVbJIhJZ1zGSOsHg
X-Gm-Gg: ASbGncuItQgORBP0CLqkDNeDysaJS14dh6c+Bqdq7rfG93dR+FB355w968H5PzUVnRJ
	zlzXRcIf2Apzt5Ctrh9Ze9IsfK/o2uE2USWjurb6GJzkayMAyrSIBpt43xwyZvUNyJ0kZDy5jQg
	7mS0iTijjym+Y50MbULMx8ebcvnD2TwdMSBGf8i94LMQEc814d7Tn5au3PXRbW3N/1/kPDZ+7MP
	5UDM+Cp5fh3N7K5c8B3tQiEseziRScddjc3ett9uT7QqFOvvwKd5Xz52srqhKj01bUe4Ft7U5Xi
	84odgStfo7KW1Rw5LgrIMnxDRdCD+rwF1T394xiVAaw0IK5f
X-Google-Smtp-Source: AGHT+IGonUIznciT1tx2HtoX+A2wSVL3IeeSpg0JpD/wMJWHHxPq99PEJzgHa9AcdioUU+SEbAOQqw==
X-Received: by 2002:a05:6512:3e16:b0:545:a2a:58c with SMTP id 2adb3069b0e04-5494c39e553mr1251624e87.53.1740767085612;
        Fri, 28 Feb 2025 10:24:45 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b8685b83fsm5930241fa.80.2025.02.28.10.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:24:44 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 28 Feb 2025 19:24:41 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z8H_aYBUHD2sS2Ir@pc636>
References: <20250227131613.52683-1-urezki@gmail.com>
 <20250227131613.52683-3-urezki@gmail.com>
 <Z8CdB0Hzvdu5ZVSI@Mac.home>
 <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>
 <Z8Ckb6spK35-Ez4U@pc636>
 <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>

On Fri, Feb 28, 2025 at 10:21:57AM -0800, Paul E. McKenney wrote:
> On Fri, Feb 28, 2025 at 05:36:47PM +0100, Uladzislau Rezki wrote:
> > On Fri, Feb 28, 2025 at 07:41:40AM -0800, Paul E. McKenney wrote:
> > > On Thu, Feb 27, 2025 at 06:44:15PM +0100, Uladzislau Rezki wrote:
> > > > On Thu, Feb 27, 2025 at 09:26:40AM -0800, Paul E. McKenney wrote:
> > > > > On Thu, Feb 27, 2025 at 09:12:39AM -0800, Boqun Feng wrote:
> > > > > > Hi Ulad,
> > > > > > 
> > > > > > I put these three patches into next (and misc.2025.02.27a) for some
> > > > > > testing, hopefully it all goes well and they can make it v6.15.
> > > > > > 
> > > > > > A few tag changed below:
> > > > > > 
> > > > > > On Thu, Feb 27, 2025 at 02:16:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > > Switch for using of get_state_synchronize_rcu_full() and
> > > > > > > poll_state_synchronize_rcu_full() pair to debug a normal
> > > > > > > synchronize_rcu() call.
> > > > > > > 
> > > > > > > Just using "not" full APIs to identify if a grace period is
> > > > > > > passed or not might lead to a false-positive kernel splat.
> > > > > > > 
> > > > > > > It can happen, because get_state_synchronize_rcu() compresses
> > > > > > > both normal and expedited states into one single unsigned long
> > > > > > > value, so a poll_state_synchronize_rcu() can miss GP-completion
> > > > > > > when synchronize_rcu()/synchronize_rcu_expedited() concurrently
> > > > > > > run.
> > > > > > > 
> > > > > > > To address this, switch to poll_state_synchronize_rcu_full() and
> > > > > > > get_state_synchronize_rcu_full() APIs, which use separate variables
> > > > > > > for expedited and normal states.
> > > > > > > 
> > > > > > > Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
> > > > > > 
> > > > > > I switch this into "Closes:" per checkpatch.
> > > > > > 
> > > > > > > Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> > > > > > > Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> > > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > 
> > > > > > You seem to forget add Paul's Reviewed-by, so I add it in rcu/next.
> > > > > > Would you or Paul double-check the Reviewed-by should be here?
> > > > > 
> > > > > I am good with keeping my Reviewed-by tags.
> > > > > 
> > > > Thanks Paul!
> > > 
> > > Except that I got this from overnight testing of rcu/dev on the shared
> > > RCU tree:
> > > 
> > > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
> > > 
> > > I see this only on TREE05.  Which should not be too surprising, given
> > > that this is the scenario that tests it.  It happened within five minutes
> > > on all 14 of the TREE05 runs.
> > > 
> > Hm.. This is not fun. I tested this on my system and i did not manage to
> > trigger this whereas you do. Something is wrong.
> 
> If you have a debug patch, I would be happy to give it a go.
> 
I can trigger it. But.

Some background. I tested those patches during many hours on the stable
kernel which is 6.13. On that kernel i was not able to trigger it. Running
the rcutorture on the our shared "dev" tree, which i did now, triggers this
right away.

--
Uladzislau Rezki

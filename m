Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CAE1DEFEB;
	Thu, 27 Feb 2025 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678240; cv=none; b=djFYh5idSOCgfjnb6ElcZS0sDPqr5PsRzCXXF6TTR3UoDRosouHkh/PuLVjK/KgTIaSfivt9Lusl3GBgqKUceZ/mqCp7fLLCe18Ur1nY2cq8zw7bfiLdGc6x8RAvEYBg5K85AB07vctdVAa8EVyskkn8pYQNurEwjpwGTpeRWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678240; c=relaxed/simple;
	bh=CJMTauSRCEWnlEAWxjoYy7NZ0L4FJshH0qmAshtRy2E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJbMGNdBbKiuUhdOpR/Hx81TalK+T2JGYmFoxpkL64eSHkiVGe+RiCs96hncui6GONxoFq+/vXUPxxH/JoQ1GWn9nrokfcKl5u2g5iHyXwWhy9b0LEKmidAKW3ZPCthzMtOkrZ5gmp/yh3KG2utNgkuELpaq6hdyX5luQHiWlkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zgw/CVow; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zgw/CVow"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54943bb8006so1210409e87.0;
        Thu, 27 Feb 2025 09:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740678237; x=1741283037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X3vEaodisrvKcNhPG/ww/1OyCGncwG4JxfefrvjSq2w=;
        b=Zgw/CVowjlcw9KCeqDPZZl/bZ0diW6phcVyDgz7Md4PKbgSACu44zDGKiCd9/tf6sg
         4QMfNCOdfbuk7bcYtKxjl8OYP2SeMjpFWE4OWVw9drvNYhUbDPQOeOKAVEOz6TO/Ko6+
         sUNIInHV26wuKMPRzDtwxrSScx3GG5ekEjLONUVkcndMl2XGY8oCBErImxwZ1oFcPH0A
         ogULPUBr0nmNR0LFiEnj0lhtNfXgCvY0VTkjcywlk6zz7ad4Re2rVpXGSzU/NGeoHhns
         NL6D9ADP+wFdlQ5ic2CIziK3PFki/fV5sl1f+yNUDfpbh7KhtWijeJfsUfRp6Q728QnX
         qLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740678237; x=1741283037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3vEaodisrvKcNhPG/ww/1OyCGncwG4JxfefrvjSq2w=;
        b=D6qjrNZKF0xz/TWF6WKzSP9Nlw+408Bdof3Uvukp6yksqL/7ks1eltTsKimax3jZu7
         AgXWiQCEsuMig/OJHSRpcTxw5hB0JUn+LsA6oVmKqPqVJcBpRVHOYsmLVKwJTlK/qIQG
         4kXzr19a1rEPdqZcnDWr3oNt/EvuosZh46eYah2AnXC1ReVf8P9jup/5XwwWSc4iIn2J
         j5PcbJlzRf4GvIKc1TOpyvxK3LoB6OZmvYzSRTLfwLekLJDaiaoxZ3TO6zAVAxDmCfy+
         mrxvyezYIQ4ITMpBH9nosN8um9cn4QH0FUElFRTgOmrpjTRBg+ldtHVcIlsd6j2eOhzp
         rsbw==
X-Forwarded-Encrypted: i=1; AJvYcCUT6JQG5+b+wKq20fUf7O5XcSzoIumWn4gNMZjJ7xbV2XLCjEpvXqD7P8O0mSWQhnvCettA@vger.kernel.org, AJvYcCVrbq8emfwmz+T5R5nDYrg8bnTVpILCZoMUDCQFZ1Hs5KtCyaeRNMWro+F3c3MZqt9RzJmTZjTJ6SrtJBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgV5tSrYYEjoFU8Mid/OQJWDsCTsBfbWXFx8YII+qg5KGblZBd
	JzGiTdQzoeJUXgeFw+Eel3HtG+OV2J42OOa5xf06cgsH4c0n1gr4
X-Gm-Gg: ASbGncsoJduz9By7kVZtGPcFmZQZf6y4ZZyAywms3lXm/tbhIow5nHxObzZIdQmhgGb
	BLwak98B2yl0FPz+WIs/Gl2DQB2ANVF4nenb43KHrjPazLV7LyNoMQFt5rxptIg5vTpO5/ewJdG
	jS6eoMQsKsogodtaVXfzTLqXzCwN2rO1wahsUDaUP9cZNtDmhsbhxmwCBBazLOub4Cmp4pMYTh8
	7Pa8lhN46wRjsnpRuRt3cUD4CSr/2fQka0fm4nYeK83qmUreM3mlB4mwkaMCi+esLR7qFOcv9Mc
	LdXD4n18hm2bGmRns3z2OjEofJKAGieT5P+7xxGhPhJ55Ejg
X-Google-Smtp-Source: AGHT+IGLQeTGJpG2m7C1VeIlUSZuQjnIL1ku5l1tB/izF3+EkRVVl1HYHlLSBB4oXrSJjG74ftT/oA==
X-Received: by 2002:a05:6512:281d:b0:545:5d:a5d8 with SMTP id 2adb3069b0e04-5494c10c5efmr143109e87.7.1740678236456;
        Thu, 27 Feb 2025 09:43:56 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443cd45dsm215760e87.252.2025.02.27.09.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 09:43:55 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 27 Feb 2025 18:43:53 +0100
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z8CkWWR4IYmrsXKg@pc636>
References: <20250227131613.52683-1-urezki@gmail.com>
 <20250227131613.52683-3-urezki@gmail.com>
 <Z8CdB0Hzvdu5ZVSI@Mac.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8CdB0Hzvdu5ZVSI@Mac.home>

Hello, Boqun!

> Hi Ulad,
> 
> I put these three patches into next (and misc.2025.02.27a) for some
> testing, hopefully it all goes well and they can make it v6.15.
> 
> A few tag changed below:
> 
> On Thu, Feb 27, 2025 at 02:16:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > Switch for using of get_state_synchronize_rcu_full() and
> > poll_state_synchronize_rcu_full() pair to debug a normal
> > synchronize_rcu() call.
> > 
> > Just using "not" full APIs to identify if a grace period is
> > passed or not might lead to a false-positive kernel splat.
> > 
> > It can happen, because get_state_synchronize_rcu() compresses
> > both normal and expedited states into one single unsigned long
> > value, so a poll_state_synchronize_rcu() can miss GP-completion
> > when synchronize_rcu()/synchronize_rcu_expedited() concurrently
> > run.
> > 
> > To address this, switch to poll_state_synchronize_rcu_full() and
> > get_state_synchronize_rcu_full() APIs, which use separate variables
> > for expedited and normal states.
> > 
> > Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
> 
> I switch this into "Closes:" per checkpatch.
> 
Thanks!

> > Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> > Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> You seem to forget add Paul's Reviewed-by, so I add it in rcu/next.
> Would you or Paul double-check the Reviewed-by should be here?
> 
Probably. But i do not remember that i got a review from Paul. Might
be wrong and have missed that :)

Anyway, thank you for adding.

--
Uladzislau Rezki

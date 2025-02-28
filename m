Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9AF849C;
	Fri, 28 Feb 2025 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760615; cv=none; b=eZSkNuBYtaBmZtZDZwTrvcFB4pI1LRJXDVLiZYZCB3NxDv8KHp0EGEkhCnUO/+G9pYueVWjnTzEF2Y+i4EfcEv5kbR+mqbjqubpGLpSc//gQEHAl3Su97iE89F6HAKuxvkdvukEI4PHGC1mbXldHrqchhYhaEv5KZW2lVMV4V2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760615; c=relaxed/simple;
	bh=f5Vl+c/3UPyb4FQoW+s8KkSFVP+u3T2ZREO0hdb0REI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uetpJG/hg2nwVeLBPK0/AdzDW593PNRnhzSxcjSSrd6BGUneZN7eQJmQo5r3V6UslF7Yi/hJPqA4Nk1POmILDHzwOmPGd2a8bnRf81P7cedWfGW9lJQAzcvOf9y7qr6MgUMyXNAKGkv8EfXqA3hYa/rd1BnJbhWT/QwACvoL8GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYyrYrmb; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYyrYrmb"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30737db1aa9so21261171fa.1;
        Fri, 28 Feb 2025 08:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740760611; x=1741365411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0fzhxTh8dWwPhVoLmGnen103y9OYjaXA/sf9AlCJoY=;
        b=HYyrYrmbexx6PUl1ABxtfpFRSXyfCHS+xA4CU43vt0tOwP0eZIRRJ/+aeazlBtAAtX
         nvXMQXnG3fT2FaP8vy7QXsYNC0iDp2yo8oOzujR6/yjNB6NoDB0TlC+4VSW++W3v+xP8
         +UNP3BbYV7Sub3ZCj+KwEj9n4yWkKQlFjbP8X3dBdFY3Q/utI8fKuK7usD1CEBz8N+m9
         EmZxzISAyOJgOh3yFJenlNb9lVrOdkMiETzf63IwaHEZYBIX79sZN6UTRGMyrGd/CJGG
         ht3WMV9ZkwSHMZJoQHf+7pZI0Z/AsSFDJuIBMxxCA4j+cwqphrzHZUcX968uXqCmXtAJ
         JfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740760611; x=1741365411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0fzhxTh8dWwPhVoLmGnen103y9OYjaXA/sf9AlCJoY=;
        b=VKBtirbmryCHnR7fVEG26bGzqMOxIIYS2IBLFPe+ZUihfWN5ucUV2v2G1d+FHS1VGS
         5PEoZLd8BWP17bCmXmslcD4BjbBI5EPRG7GEWBfmgtVoo+d5eayAJSj1/5boLpzcXSMj
         iTpmks7JqEmYip+fRr3g+ZNOiTZKrZAVrnTlls2m0fseMMVBPohw9eUb3KwGzx4hVr3G
         FJDNyST/X9o62T+3I6Sz1CyZH1IHJmF75xRAQ6sruFdcZgx9TLFWBKebQjd88rjENdtG
         6JtZDpq2urlzEtkfGWYjgK0V7CmxBT/ngUurz3Fm8xtiLWCHrW24ASe8n/5ZCugeHe5D
         zArA==
X-Forwarded-Encrypted: i=1; AJvYcCV+mR8RYbuwq6p3seUZN/pWbGoI4/nRIwNK/4JxSI5iaWBFUXhU2kItgusTM4tz3C7n2ONL@vger.kernel.org, AJvYcCVMIuXdL4s43DRiJ+qW1baWrHayiCMtGoA6p4Lb78s9W80Hd3TZJIYU8B84/JAIfHFnSbqJ+oa7tWa7TuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYIA6mkm/MnS4blPExIBtoZGAf/0k1fNmje652LE02UbtpC9LX
	0WFDPf7MI+yFhNHi8Rpu0hfGj92SyxxWN2ZCqyV86js1AFTLee+3
X-Gm-Gg: ASbGncuKxhhM94Bv5QKe1RDFod/TUs9erqWpAYxDAOzqS7vVn5OkyyoxT5AergyvClB
	E2vZtIbSXrg/EUdaofFJcY2JVjPbrUkKZip/VfSyeKyXsjoIdrxz9ZmBuo1V9KTRc8g5sqCsVOZ
	Kgl0dk20/DQX7eXmjGnK+F0sk4xxb4L++Feb5/fUdfmz/jtfGh1ncRjY+YZt1GIw2rxwWy8CDvu
	3yy07n7FPpCcFNRdbOlYAx9FSRbigFxrjtxsUa6NlH+a0ssgU24PSU6VvAyjpFTeW9a73Kcuujn
	3+57XUjzfv38J19grsyu6Kgkj0dRJ/tzdBXbpJcMmSWcs/cR
X-Google-Smtp-Source: AGHT+IFYJceD4fh/lNOPw+Ami7jUwQC631WCACN8tEiHvhXnlJUP0YNJgBfciMu1s+t18njTGZuzVg==
X-Received: by 2002:a05:651c:228:b0:309:17:750d with SMTP id 38308e7fff4ca-30b93413820mr14699801fa.27.1740760610813;
        Fri, 28 Feb 2025 08:36:50 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b86878615sm5598401fa.101.2025.02.28.08.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:36:49 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 28 Feb 2025 17:36:47 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z8HmH85bYNU8enJ2@pc636>
References: <20250227131613.52683-1-urezki@gmail.com>
 <20250227131613.52683-3-urezki@gmail.com>
 <Z8CdB0Hzvdu5ZVSI@Mac.home>
 <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>
 <Z8Ckb6spK35-Ez4U@pc636>
 <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>

On Fri, Feb 28, 2025 at 07:41:40AM -0800, Paul E. McKenney wrote:
> On Thu, Feb 27, 2025 at 06:44:15PM +0100, Uladzislau Rezki wrote:
> > On Thu, Feb 27, 2025 at 09:26:40AM -0800, Paul E. McKenney wrote:
> > > On Thu, Feb 27, 2025 at 09:12:39AM -0800, Boqun Feng wrote:
> > > > Hi Ulad,
> > > > 
> > > > I put these three patches into next (and misc.2025.02.27a) for some
> > > > testing, hopefully it all goes well and they can make it v6.15.
> > > > 
> > > > A few tag changed below:
> > > > 
> > > > On Thu, Feb 27, 2025 at 02:16:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > Switch for using of get_state_synchronize_rcu_full() and
> > > > > poll_state_synchronize_rcu_full() pair to debug a normal
> > > > > synchronize_rcu() call.
> > > > > 
> > > > > Just using "not" full APIs to identify if a grace period is
> > > > > passed or not might lead to a false-positive kernel splat.
> > > > > 
> > > > > It can happen, because get_state_synchronize_rcu() compresses
> > > > > both normal and expedited states into one single unsigned long
> > > > > value, so a poll_state_synchronize_rcu() can miss GP-completion
> > > > > when synchronize_rcu()/synchronize_rcu_expedited() concurrently
> > > > > run.
> > > > > 
> > > > > To address this, switch to poll_state_synchronize_rcu_full() and
> > > > > get_state_synchronize_rcu_full() APIs, which use separate variables
> > > > > for expedited and normal states.
> > > > > 
> > > > > Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
> > > > 
> > > > I switch this into "Closes:" per checkpatch.
> > > > 
> > > > > Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> > > > > Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > 
> > > > You seem to forget add Paul's Reviewed-by, so I add it in rcu/next.
> > > > Would you or Paul double-check the Reviewed-by should be here?
> > > 
> > > I am good with keeping my Reviewed-by tags.
> > > 
> > Thanks Paul!
> 
> Except that I got this from overnight testing of rcu/dev on the shared
> RCU tree:
> 
> WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
> 
> I see this only on TREE05.  Which should not be too surprising, given
> that this is the scenario that tests it.  It happened within five minutes
> on all 14 of the TREE05 runs.
> 
Hm.. This is not fun. I tested this on my system and i did not manage to
trigger this whereas you do. Something is wrong.

--
Uladzislau Rezki

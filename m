Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2F8286288;
	Fri, 28 Feb 2025 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767409; cv=none; b=q3A8+S7/pKW0GJF8Va1PZsDadmNIJvV5IhyHHdjtLETZ2LxnskIDb/Fes4P0ImYFPzTXekrjwuoJ7CqSZvPMTwLipOLDiHIeWC2/OzvLL9OJmKCvPRqg7p+VWqoQzD58qJ8h4KenjObpZ52vXUBqi0LlQxteGMWnYy+je5wFJVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767409; c=relaxed/simple;
	bh=rEj78UcFQDAHphVHUC5xoGH16EIO4LDyE10+E990cOA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5TXQOwHbkOHRcB9iwwAVS6/1wYHhPZPVJgzsNTTENfv2PiblX8UympBy9+zb+V3BjI10xJli6yxqanBKlW5sxvnnmppu9u0i9Ysdhhwt/yXkgUDWjO47WDB3gqOfh8ZirK0JNZy7Fy16m8VIX2OakKXGOOFnX59lq0SlyNNtrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvN7UDtz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvN7UDtz"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5494bc4d741so1598486e87.2;
        Fri, 28 Feb 2025 10:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740767405; x=1741372205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IyGlG6KmyWC/vhmNe6q6s0Da+XSfS6Lsa7LYaDsWvDU=;
        b=TvN7UDtz2EMmxWZFFkEZ7nNpJw8tnzopV6chW1g47WDX7rlIZK0+3C+bcolwLGq0Kr
         17Rnv619jDG2s1sMK2/+n2RFGl1yajlRiOusGCAs5/tNaXDZCyUfVSwdGqIBl3Kjoa8b
         Snd2qwncmIQHh29YXyXIb/7HmS8wrWQf7WDFZNEP6uyn/oxLoa4I0iXQvR9Kwu54njSQ
         KyVl2dAIvJVKJeAsJRBM3P7eU27/ycieKax4qpjzalDhwJu5D20C7N3jYHhDHHnrtpOe
         AGWh2BJajlfI4KKMq0M2mbh9TQ/aQfbqtuLsblultRossT4m7Bteb6DlAN7GMTNoVZy/
         I9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767405; x=1741372205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyGlG6KmyWC/vhmNe6q6s0Da+XSfS6Lsa7LYaDsWvDU=;
        b=RDau0RzIXsKdI5dLHoLlSj4cwp1seT6kha57MhyqVYIul1EWkw5PSVQSV4qW2YMsyY
         U5fCWA+a+73BaS7yRqc9EKchGTLfibP2ZPABjdEhiFUZz1KP+EPLysVYXRippjyPB1zB
         RgJRbyfir5Spgu5Ad86wcG4Rio5NO9EaxnCsdd7SXWFYrBH5sYvbFiHYNPHTrTFd7fxT
         7oIoyeQtU75skP2G8w3mVVLAnTOtMUy2W5Jn7yvKlQCd6R8BeVwo2mBvn50RyqB8ovGG
         wZlY5vwY5HqPBPaXQkpvp1WNMWrcZIrIkCOhd20Od3MfYUd26E0aZVjBwPUaErzGKVIw
         5nhw==
X-Forwarded-Encrypted: i=1; AJvYcCUuZ7mo7bGIYadBvr1sNA3AztvISQu+eQds+RLFt700zuNBJS2pxvZMY6aw7KKzVXS9tOW0@vger.kernel.org, AJvYcCWmWRdYUFFy3LyInSqUODCWvgJt58EpjZtwyqt0FMJ+2lrZTOGYSrOPFnehg7lJjdgUC4h9DBYPNLpQsEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7xvuOziBpRhwRpeHv6ulfA3tZ70qOpZOpIkGR9Izgw2WUenz
	e0FzjhC5cTHx0bOLHDRzA6WKkvBsuOq+KSPGLr+/w+ahFxxuftUy
X-Gm-Gg: ASbGncta4N/luzb+XC9GE38P7drsyWTwi79foyiwJVpm/wWa9n4JqK1bDgvhH1zvaif
	nKoBf4f9aEqV/RP0Yrv2PYbhYVQVhQf2lgrjxSiFkg2L3jyHe6sLd73z0tAbaBeqhDqsXH7li4/
	u/n34WhKU71761BAIoSDbRpiX2zGVKh0afJfeDpqZPo8qnp4uNtPt35b1J59qKCtIbueDUzo7uE
	34dulpUI89QY+yeC9zPyY69gCvqy20jwPsIFVVwYWQV3LfTBO+hJoe8ZIjkZyGXsS8VdaFiP7v9
	xYJy3cefEoMzCWhW6xzt4JJoQaeFRz73Cns4MALsbIlWpI0c
X-Google-Smtp-Source: AGHT+IEkJ6IMmCKxPFsLqxJMA1GDDzT6covfWgsgXVKfqGf1wEovMTD7mrXAregnRjEGvq2NaapgDw==
X-Received: by 2002:a05:6512:a8b:b0:545:2302:6835 with SMTP id 2adb3069b0e04-5494c107e6bmr1828479e87.2.1740767404684;
        Fri, 28 Feb 2025 10:30:04 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549441741d4sm573051e87.33.2025.02.28.10.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:30:03 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 28 Feb 2025 19:30:01 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z8IAqQ3dYdDsj5GN@pc636>
References: <20250227131613.52683-1-urezki@gmail.com>
 <20250227131613.52683-3-urezki@gmail.com>
 <Z8CdB0Hzvdu5ZVSI@Mac.home>
 <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>
 <Z8Ckb6spK35-Ez4U@pc636>
 <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
 <Z8Htg565HnNumdxy@pc636>
 <6e4688d1-afe7-4508-9ebc-eeece0692365@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e4688d1-afe7-4508-9ebc-eeece0692365@paulmck-laptop>

On Fri, Feb 28, 2025 at 10:25:58AM -0800, Paul E. McKenney wrote:
> On Fri, Feb 28, 2025 at 06:08:19PM +0100, Uladzislau Rezki wrote:
> > On Fri, Feb 28, 2025 at 05:36:47PM +0100, Uladzislau Rezki wrote:
> > > On Fri, Feb 28, 2025 at 07:41:40AM -0800, Paul E. McKenney wrote:
> > > > On Thu, Feb 27, 2025 at 06:44:15PM +0100, Uladzislau Rezki wrote:
> > > > > On Thu, Feb 27, 2025 at 09:26:40AM -0800, Paul E. McKenney wrote:
> > > > > > On Thu, Feb 27, 2025 at 09:12:39AM -0800, Boqun Feng wrote:
> > > > > > > Hi Ulad,
> > > > > > > 
> > > > > > > I put these three patches into next (and misc.2025.02.27a) for some
> > > > > > > testing, hopefully it all goes well and they can make it v6.15.
> > > > > > > 
> > > > > > > A few tag changed below:
> > > > > > > 
> > > > > > > On Thu, Feb 27, 2025 at 02:16:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > > > Switch for using of get_state_synchronize_rcu_full() and
> > > > > > > > poll_state_synchronize_rcu_full() pair to debug a normal
> > > > > > > > synchronize_rcu() call.
> > > > > > > > 
> > > > > > > > Just using "not" full APIs to identify if a grace period is
> > > > > > > > passed or not might lead to a false-positive kernel splat.
> > > > > > > > 
> > > > > > > > It can happen, because get_state_synchronize_rcu() compresses
> > > > > > > > both normal and expedited states into one single unsigned long
> > > > > > > > value, so a poll_state_synchronize_rcu() can miss GP-completion
> > > > > > > > when synchronize_rcu()/synchronize_rcu_expedited() concurrently
> > > > > > > > run.
> > > > > > > > 
> > > > > > > > To address this, switch to poll_state_synchronize_rcu_full() and
> > > > > > > > get_state_synchronize_rcu_full() APIs, which use separate variables
> > > > > > > > for expedited and normal states.
> > > > > > > > 
> > > > > > > > Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
> > > > > > > 
> > > > > > > I switch this into "Closes:" per checkpatch.
> > > > > > > 
> > > > > > > > Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> > > > > > > > Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> > > > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > > 
> > > > > > > You seem to forget add Paul's Reviewed-by, so I add it in rcu/next.
> > > > > > > Would you or Paul double-check the Reviewed-by should be here?
> > > > > > 
> > > > > > I am good with keeping my Reviewed-by tags.
> > > > > > 
> > > > > Thanks Paul!
> > > > 
> > > > Except that I got this from overnight testing of rcu/dev on the shared
> > > > RCU tree:
> > > > 
> > > > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
> > > > 
> > > > I see this only on TREE05.  Which should not be too surprising, given
> > > > that this is the scenario that tests it.  It happened within five minutes
> > > > on all 14 of the TREE05 runs.
> > > > 
> > > Hm.. This is not fun. I tested this on my system and i did not manage to
> > > trigger this whereas you do. Something is wrong.
> > >
> > We have below code to start a new GP, if we detect that processing is
> > starved:
> > 
> > <snip>
> > /*
> >  * The "start_new_poll" is set to true, only when this GP is not able
> >  * to handle anything and there are outstanding users. It happens when
> >  * the rcu_sr_normal_gp_init() function was not able to insert a dummy
> >  * separator to the llist, because there were no left any dummy-nodes.
> >  *
> >  * Number of dummy-nodes is fixed, it could be that we are run out of
> >  * them, if so we start a new pool request to repeat a try. It is rare
> >  * and it means that a system is doing a slow processing of callbacks.
> >  */
> >   if (start_new_poll)
> >     (void) start_poll_synchronize_rcu();
> > <snip>
> > 
> > we do not use a _full() version, since we need to inform rcu-gp-kthread
> > to initiate a new GP.
> > 
> > Any thoughts?
> 
> My kneejerk not-to-be-trusted take is that it does not matter which type
> of grace period gets started so long as a grace period does get started.
> Presumably you have done the get_state_synchronize_rcu_full() before
> this point?
> 
Yes, of course. That code is located in the gp-kthread. get_state_synchronize_rcu_full()
is done before.

--
Uladzislau Rezki

Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E0517836F;
	Tue, 11 Jun 2024 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100768; cv=none; b=OKqE4oTDbcY5yAaf6LIaTZIJRMZ103yU3Wepw9nfw8EOFxsBoHMWEEz7zDJ5QHLW0Sim9Cuoza10jRLdhTvUqbv9xqF+TFQGLsjWlpPBsMjVJH3cGGRpq+XGzZmD51Qk4T9IHGRVveoCpszM63HtGTUYD7I7OlDqhGj7CNQ9Ku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100768; c=relaxed/simple;
	bh=hHq7rsBFDq0EqNnuYPQ1CAP+SGwfC+85cs43Miwvbwk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AX3cB7kGtIQnyxvTwbWQR+GLDNtN0VYm9jWf6swl1j63tFnrysmsBoDSEKjFG/txv9wIsjeotTQ/dTX1oXCeg6WYAjHrV9oWSJ1Ruw0GobyRMDK4mMcOIvL4YeF2JBPqMp78ubZQItiUOhzJ3L+mxTNo9tdV87iscY7I7gK9Zrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XF5tygky; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF5tygky"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebd95f136bso9059821fa.0;
        Tue, 11 Jun 2024 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718100765; x=1718705565; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2FKak35VIiYwM8SAujbX9oYKzoQLHlkNtzmJ5k52VYs=;
        b=XF5tygkyT1RbLf0yFFfzpjBEjpmvSHWL6DDTiK6rJt0Gt4Ydgz8ky+FHjPfZk8d7C8
         a6kLqA+An1P8fXeICCxFJdwyEymX5x/UQfrHhOVaG7Pb92rnNkrfq+FpWoHlFXgYpHiz
         7HUAknBP/iqc3lf0NfjrrFMQHoAU+ALrd8v4mVXDxdHj1wgQJwXZ04CCMDcC2O0/ACDp
         7lVyvUPr/WNW0DYQyfnnvTbPGADYbd1KHGt+TH405MU9sgv2sdCjZKhdl/XqZRLbFQh2
         UvrdAfmK5otvjqLCKqV8zXg26uhTGpNBKZf2Q5mkd/Y/Slmy5vTBuoXPrLCaSxrgVUMY
         Jw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718100765; x=1718705565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FKak35VIiYwM8SAujbX9oYKzoQLHlkNtzmJ5k52VYs=;
        b=p2kWx616qP87C7DdC2GCLq6cF6M1Fld7xdRTXEhBphtiEHAlE44zkWIy8aDSPKfUZH
         MthuKT3GnRNHKnIU9wUeP5XRvelx7VHbV3+Vpduk8d2uBUdhQ3RrelA1h2tedLkLsH18
         KxwxgTPeR0j3cP0sqS1qL5Ij3ivlJu0cPfOVITBnVpykLtom7LmNoj5c3a+ICjUVCnMC
         qmgzD26TTwul6y+PgXEeMB1gleGnkAV925rZc19bACZIu63RHpRRs5Sw+xJLS/Mb7Gzq
         TmjOjXt+jT821r4smQwPxzVpGDZ+CwU72J7+p3slFqqFbbp1ikUTdT1i045pQt2GXtzM
         hT8A==
X-Forwarded-Encrypted: i=1; AJvYcCU3YhD4mfgBJTivljzNFgzyr3So6jDQqp2NyX1gKYmh9KB7sJZea84CJiilMQcRHQzcg9fgH6Dymt2u3p6mJhNm9wHuWhtF/art+IGftXBNlAJQWUdnd03aQQBUgis7kZ0z
X-Gm-Message-State: AOJu0YxF5plPd5rEolu8XON1Zn4LUn9kM0L07wGZ4vtLKcYGb/48bOyy
	5zX0dElczSWqFZIN/pH1em6Rj5qDXYWOmDgKfvPlW6UyYH3qwIy1
X-Google-Smtp-Source: AGHT+IFqxkEHeFSRbrMxnPFKPJEiNaoRvYCebSTK4U7KrRNNGFlGxa8V+twgJbUCwSME/kpyvOOKGQ==
X-Received: by 2002:a2e:3603:0:b0:2e9:6e43:c897 with SMTP id 38308e7fff4ca-2eadce82d72mr71336111fa.48.1718100764800;
        Tue, 11 Jun 2024 03:12:44 -0700 (PDT)
Received: from pc636 (host-90-233-193-23.mobileonline.telia.com. [90.233.193.23])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebee031c95sm6061191fa.101.2024.06.11.03.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 03:12:44 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 11 Jun 2024 12:12:41 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 2/9] rcu: Reduce synchronize_rcu() delays when all
 wait heads are in use
Message-ID: <ZmgjGdRLCg3tnuBC@pc636>
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-2-paulmck@kernel.org>
 <ZmBVfpyEZeTIAHJn@localhost.localdomain>
 <c7d07e5d-34a0-4874-8e7e-1c576c14c8e6@paulmck-laptop>
 <fbc30c3a-ecd3-4525-9434-307c7769bb4c@amd.com>
 <a0aa3d5e-006c-475d-bd2f-b15fca47deee@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0aa3d5e-006c-475d-bd2f-b15fca47deee@paulmck-laptop>

On Thu, Jun 06, 2024 at 09:49:59AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 06, 2024 at 09:16:08AM +0530, Neeraj Upadhyay wrote:
> > 
> > 
> > On 6/6/2024 12:08 AM, Paul E. McKenney wrote:
> > > On Wed, Jun 05, 2024 at 02:09:34PM +0200, Frederic Weisbecker wrote:
> > >> Le Tue, Jun 04, 2024 at 03:23:48PM -0700, Paul E. McKenney a écrit :
> > >>> From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > >>>
> > >>> When all wait heads are in use, which can happen when
> > >>> rcu_sr_normal_gp_cleanup_work()'s callback processing
> > >>> is slow, any new synchronize_rcu() user's rcu_synchronize
> > >>> node's processing is deferred to future GP periods. This
> > >>> can result in long list of synchronize_rcu() invocations
> > >>> waiting for full grace period processing, which can delay
> > >>> freeing of memory. Mitigate this problem by using first
> > >>> node in the list as wait tail when all wait heads are in use.
> > >>> While methods to speed up callback processing would be needed
> > >>> to recover from this situation, allowing new nodes to complete
> > >>> their grace period can help prevent delays due to a fixed
> > >>> number of wait head nodes.
> > >>>
> > >>> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > >>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >>
> > >> IIRC we agreed that this patch could be a step too far that
> > >> made an already not so simple state machine even less simple,
> > >> breaking the wait_head based flow.
> > > 
> > > True, which is why we agreed not to submit it into the v6.10 merge window.
> > > 
> > > And I don't recall us saying what merge window to send it to.
> > > 
> > >> Should we postpone this change until it is observed that a workqueue
> > >> not being scheduled for 5 grace periods is a real issue?
> > > 
> > > Neeraj, thoughts?  Or, better yet, test results?  ;-)
> > 
> > Yes I agree that we postpone this change until we see it as a real
> > problem. I had run a test to invoke synchronize_rcu() from all CPUs
> > on a 96 core system in parallel. I didn't specifically check if this
> > scenario was hit. Will run RCU torture test with this change.
> 
> Very well, I will drop this patch with the expectation that you will
> re-post it if a problem does arise.
> 
Thank you! We discussed it before and came to conclusion that it adds an
extra complexity. Once we hit an issue with delays, we can introduce it
and explain a workload which triggers it.

--
Uladzislau Rezki

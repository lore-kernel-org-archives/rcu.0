Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CEB40962C
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196748; cv=none; b=kkC2O7DROzmfM5kW4/9PmHjl1p07/MQLRmIbq4DKHXizBjxyzdgP06WC58p5x3v+C/zREe0OUDK7ig7LwEXskxp8DxSDxnru3ZzqTLqzcFwXtVONaOdhrCnYWDdYHzYlQkAhvKy4aNtoya8yHxoCVCdIeUi9YzKSMCYAhKKdASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196748; c=relaxed/simple;
	bh=bj1q/EztfJJU5GWMwa6IstXsS/eEjz5iuLTnwo0VwBo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCumyjLpaTLvb3/fj4a59rxrF3Dk7RCgMrKRhBRSx+nVmtiegG/1GhtbQr1cVrmeUOvYnTmsvZZqJp+mel8sliimXb6pHrOkD5t+K5IgzF0y+OX4fgbJOWLd3jg6p4elK8osk6luo34EYYGy3At2HL5sNtRGTZrz8qmzUFHHhjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6CYuMXg; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6CYuMXg"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3939d2bd739so30311461fa.0
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779196743; x=1779801543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1VUcKWR6tSOqnS3x6S3T/ExY2OOAzTCVhWmP/IsAKgs=;
        b=f6CYuMXgPHr8n8DaXLizBBCHfw+cpmRb8SFfKSWdhBBtX9ZZtDBXy0GZCuTWScn3MB
         B+UQzIMlVO/EQqwVch++mrbu5ZMFOaMaDjG3rdVDluB/R54DG2TrS7LVn8oAjVbASPVi
         up8+ReYZLuPWynJt1YhZ4lxqSaOagx1bauvN6EwQErfuFBIZCWDSa1kGPCK7AzKgTgHy
         3cThewQAlrKvYITiWuFazOeqxgalxZG5gufQ6zTcJRQBqQZZ6Swt8QHq1a8ckP+WFXcW
         kRnRKzzioTOJsTfkz16kx8PSNvTSsGy9R3b42LckJAIz834p9l4t+kPxqH626X/Pbd5o
         OmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196743; x=1779801543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VUcKWR6tSOqnS3x6S3T/ExY2OOAzTCVhWmP/IsAKgs=;
        b=TR4ghyMz0WgSwCQzB3NxXBZP8SX1/17s5F/w87m2irKSLip1BT8k7AuNLoKCaG+kfi
         xowzKSC5ofcwUgTTSSi4bdYGZ0a3c9rpAQySHAkjYflSpfccUzkEUOLNFW+qDMJgfYjV
         BtpTVtHRhBw5s4S+SwGyCC60cO/eFhfJr6fFdVAqjWjbUf2G4Ed7mllKaf2jZes3Zp8P
         WcLr1XBuD3rQOcItDK9iCr9MOmJF9zxoAn+dO0B4P/w2zUlIK5pW548cR5irGf2XC5rK
         pj33+b7AdDMdO8+tAjv8bUYHRK6hRTdGUNOiIZgNuCVHYx0iuZg+Zxi/Bf8aGUqIkhhC
         JzTg==
X-Forwarded-Encrypted: i=1; AFNElJ8IEULoVeCsU6HJfI6QcdKUmZD8LAykADBBJwcUzb5eyonvsAPMkJAFWh2A5XgS7gnKw18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMcrAA6q1px8/1lCEHi1Ea/ZTf1M5RyrPFsGpRKVmvO/bUUWBO
	EKVt60gZptgqUESFH1NnKa6/jZMSUL4/uB5iiiH69bHMNt4B6/WyJcpu
X-Gm-Gg: Acq92OGgodMT9O8QXP9MtIU6LC9UcMKpgEVx+7MPn8sh/rerxcBDExU7xOF8dPgTO40
	OeFIHWGiMzDemCNicK9RPzZar7v7GfmiNoe60a/3dVbA7C95mTltn6FZnK/Wq/k0tWLIQeFkA5P
	1/M6yBPeycaNRlR5zUd2tEDvK/D9ONNIgoYdeQnvsnt+aS4uwElb4QdaEiLb1ynZ4fuoKSMgksl
	ZZRKH1neCd33y4zXlwssetUKKZRQsSwtTer83JkLN3PrEbAzOhGMuUUqVjjirBgBeb09gZ9F8jx
	sD1a+KbWfF/ppdWI8/nmtqmx1aGMQz7mRc/farT4h3F2wfhZ1Pw+1AdpemtvPxU5WHg3C0iZHzQ
	iqMHHUqwSXdRgmRX6EeXoCdEo2fW6B7P54IrSMVVVbPpYvawaJthuk9RFFhoFrkn/
X-Received: by 2002:a05:651c:555:b0:393:903c:2256 with SMTP id 38308e7fff4ca-39561faac30mr55035051fa.26.1779196742768;
        Tue, 19 May 2026 06:19:02 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958827ec4csm19757351fa.4.2026.05.19.06.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:19:02 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Tue, 19 May 2026 15:19:00 +0200
To: Boqun Feng <boqun@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>, paulmck@kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Samir <samir@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH -next v1 05/12] srcu: Don't queue workqueue handlers to
 never-online CPUs
Message-ID: <agxjRHuAnzHFDqD9@milan>
References: <20260511175448.153326-1-urezki@gmail.com>
 <20260511175448.153326-6-urezki@gmail.com>
 <f669fbc9-c068-489f-bd91-4e81561a6e58@leemhuis.info>
 <agm4-6f-6rOgQPFB@pc636>
 <3dd5cce0-51f9-4cf1-81b8-246e6c6a633a@paulmck-laptop>
 <53d546e4-8db0-4e14-a79d-270212081be7@leemhuis.info>
 <ags6ug97zNR6Fiiw@tardis.local>
 <agtG4JmmyH1ycg16@milan>
 <agtowPsNCB2LioTN@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agtowPsNCB2LioTN@tardis.local>

On Mon, May 18, 2026 at 12:30:08PM -0700, Boqun Feng wrote:
> On Mon, May 18, 2026 at 07:05:36PM +0200, Uladzislau Rezki wrote:
> > On Mon, May 18, 2026 at 09:13:46AM -0700, Boqun Feng wrote:
> > > On Sun, May 17, 2026 at 09:11:10PM +0200, Thorsten Leemhuis wrote:
> > > > On 5/17/26 20:03, Paul E. McKenney wrote:
> > > > > On Sun, May 17, 2026 at 02:47:55PM +0200, Uladzislau Rezki wrote:
> > > > >> On Wed, May 13, 2026 at 12:38:01PM +0200, Thorsten Leemhuis wrote:
> > > > >>> On 5/11/26 19:54, Uladzislau Rezki (Sony) wrote:
> > > > >>>> From: "Paul E. McKenney" <paulmck@kernel.org>
> > > > >>>>
> > > > >>>> While an srcu_struct structure is in the midst of switching from CPU-0
> > > > >>>> to all-CPUs state, it can attempt to invoke callbacks for CPUs that
> > > > >>>> have never been online.  Worse yet, it can attempt in invoke callbacks
> > > > >>>> for CPUs that never will be online, even including imaginary CPUs not in
> > > > >>>> cpu_possible_mask.  This can cause hangs on s390,
> > > > >>>
> > > > >>> Uladzislau, Paul, according to the fixes tag below this change fixes a
> > > > >>> change that went into 7.0-rc6 -- and apparently causes a "hang" on some
> > > > >>> architectures. So shouldn't this be heading to mainline instead of
> > > > >>> -next? Ideally with a stable tag to ensure backporting to 7.0.y, but
> > > > >>> that is a separate decision?
> > > > >>>
> > > 
> > > FWIW, I'm happy to create an urgent PR to Linus with this fix. Since it
> > > fixes a commit in the previous urgent fix PR from me. Ulad, let me know
> > > if you want me to do it.
> > > 
> > I do not mind :) So i can drop this patch!
> > 
> 
> Alright, I created the fix branch at:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git/log/?h=fixes.v7.1
> 
> And I'm going to throw some tests on it. Will send the pull request
> tomorrow.
> 
Cool, then i drop this patch!

--
Uladzislau Rezki

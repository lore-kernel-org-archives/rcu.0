Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A6E1FAC59;
	Tue,  4 Mar 2025 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085553; cv=none; b=oaOASPYS1WjIbatbWLk7qRFKnC1XYPtG8a/3iZaTDX16cVwkg7JeO7Gj6NALFLmeGYmyfDbE6Je+wvympVk7BqAlJeb3mc01uPBkonoMq9x4VTVqfCpr2lbUkrdPrgz2/WNaOr/sIop9QiinrSwZrCsh3zosCKvsrsZgV3SrXw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085553; c=relaxed/simple;
	bh=j8t2vG8K2ktYqpUbC5SvLN1eHryBSP6okv4cMZrKszM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs2wyOHKbOsiZx/VVGkjulAtKvBlQh6+X5JCaxrzq6Lbw8wyP6O3yaXcV4OcJNNJ9yXX13AaBFZJFc3s4W7QUaQ0GgNY6wRp6/yxMWsLK/uicQ2OozrnRCpbaBKqB5GzpDoPfyV2/lbVwLIuONHTvQTA3RoFMfBqOJ1ScUKJkAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2vSvTeQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2vSvTeQ"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5452c29bacfso6001916e87.3;
        Tue, 04 Mar 2025 02:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741085550; x=1741690350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gWewbNXYilovO9nAVA1KkJAf5VT1tC1W6c4bmyggmpQ=;
        b=N2vSvTeQh+GXQKJ767x4ala7VrB26lMk1LyK/bqyBLZBnORteOc/UAbxJx9jUoR+OT
         Saw780bkQCe4vz0IbXX66haXJ4rCScIX8trNukDCsZIx0vYft0FeqISHYPE2hT3BVeZM
         JxKEflDb/Yd+VG1zEQY+kDWs1jkpCkO/VgCZ0eLCCeWcLCXdTOKGTqRsxk9FB2H8dNJw
         C8mYs+srs8gh0BRrzJUcjsJcQFC8HRTcfqTqHfl4ySjPFxETtveL/ilyrDMjUrlwJYSR
         yII5jx+QzwRieohR3josqiePld32QrovssiU8GHQF9pyClueuS7hQD1FM1n8a/NPUgqs
         PHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085550; x=1741690350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWewbNXYilovO9nAVA1KkJAf5VT1tC1W6c4bmyggmpQ=;
        b=xJ7UNNkZXSNTLeQk6ZtPsU0EbaJdggFmFdp0Rvu/6Q+iF6O/T9Lds1FzzBIwLOdK0t
         lGdotkhIXAnjkrtQnUSPfDN2/pI1JkTer2uC99LbBieYGimtlhWlvem2/Yiu8MJ7ookI
         Uzrb5Axc4tx1eNXc1KwrG2Ux4US2DqpSbau5f8RQhT0VBJLeZLPoXroekPIDxbFGQTQh
         6eOj593ChKMSqhN5WvRjeQWCATmX7BSHwrftgbByK/s6yMlgVFQwDzmI4bSKyW/nOujD
         R+xlSVpE3JKPOuAFm2MINN0xmxmdT70Sg6NZVroQG7K/3szry8D16GKRk15Ti/bv4HNJ
         BJyA==
X-Forwarded-Encrypted: i=1; AJvYcCVjDyzWwZ8QHpRHDtJ/Jq+tlqEj5qMt9Aa29Kj6A8/AHB3LKsIMTkiz3oS1YfG7nKkFUnez+pQG8Ruf0cs=@vger.kernel.org, AJvYcCWEZ4RiivtmteyS3+NGQGrFI0b8TN/fqei4XijQ4jECSGK6mkxQRQ8jXa8liLpOBn7sXl8V@vger.kernel.org
X-Gm-Message-State: AOJu0YyUEuqArKzt/I6lDs1gOCnvItCH00TFhoCs7wZdWiG6JK184CWJ
	jXl27qi75e8g7+4uA2PExIxjVrJSmQmsr0S9o2P6SvqvfgX5Ludx
X-Gm-Gg: ASbGnctfjWpxOtdWUMvjQQg7qWZmSAH4DCM92nj46WVr5QU5AkWvddbvt/yiSpUkrZY
	tqCp2tSQWSxoby4gBZr/djr/6JmeNCFjUzwg1vj7ojnbrillSTCgaHtF/1skuk98lfCEBNIPlbc
	8g0Z7C5Kguv+ZBW4fbakiTIRz7xS0pASsFDZd6b/7HwzdozNz1uJnneRuZdiBySSGlVYxXTSU/y
	ivR5X2Fw7HH6R+CNxRF1EeCNmIct7+yURRfurAKUSHelvVL/s1Z0f4X+u9Tk11bLK4XtUvYze4W
	J0WkYXpBi5zDMSwpoZbRLI1FfuLHig4qWqVbA1ulEoL6/arI1XuJSFoNf2wxrELNTwI=
X-Google-Smtp-Source: AGHT+IG8kgKfpGG4n/YSX41vVjX1+n0ye29JCvFsfWOni1nyuIrzy6/5dr7Z8Gpr1hYii8cqhvYs2g==
X-Received: by 2002:a05:6512:1085:b0:545:1d96:d702 with SMTP id 2adb3069b0e04-5494c38c05dmr7304997e87.48.1741085549756;
        Tue, 04 Mar 2025 02:52:29 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495804887dsm1059599e87.188.2025.03.04.02.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:52:29 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 4 Mar 2025 11:52:26 +0100
To: Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z8bbary51FZ2TsUA@pc636>
References: <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
 <20250303001507.GA3994772@joelnvbox>
 <Z8ZyMaUhXMIxX7WE@tardis>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8ZyMaUhXMIxX7WE@tardis>

> > Did I get that right?
> > 
> 
> Other than I'm unable to follow what do you mean "WH has not been
> injected, so nothing to wait on", maybe because I am missing some
> terminology from you ;-) I think it's a good analysis, thank you!
> 
> > I think this is a real bug AFAICS, hoping all the memory barriers are in
> > place to make sure the code reordering also correctly orders the accesses.
> > I'll double check that.
> > 
> > I also feel its 'theoretical', because as long as rcu_gp_init() and
> > rcu_gp_cleanup() are properly ordered WRT pre-existing readers, then
> > synchronize_rcu_normal() still waits for pre-existing readers even though its
> > a bit confused about the value of the cookies.
> > 
> > For the fix,
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > (If possible, include a Link: to my (this) post so that the sequence of
> > events is further clarified.)
> > 
> 
> Will add the tag (with the email you really want ;-)) and a link to this
> email to the patch. Thanks!
> 

CPU_1:                                | CPU_2:
  # Increase a seq-number             |
  rcu_seq_start(&rcu_state.gp_seq);   |
                                      | add_client() {
				      |   # Record a gp-sec state 
				      |   get_state_synchronize_rcu_full(&rs.oldstate);
                                      | }
                                      |
                                      | rcu_sr_normal_gp_init() {
				      |   add a dummy-wait-head;
				      | }


A client has been added with already updated gp-sec number, i.e.
"oldstate" would refer to this GP, not to previous. A poll_state_synchronize_rcu_full()
will complain because this GP is not passed, it will on a next iteration.

This is how i see this.

--
Uladzislau Rezki

Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110231804A
	for <rcu@vger.kernel.org>; Wed, 23 Apr 2025 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392643; cv=none; b=QuDS7paDFyCtCzSpWLwEmjD+59DFv1XibVDIDF45tinCil0FkLzP78j6Lo/XzC6o/jEnu9p0LIUza7fEQBk9YK2ID81H92JoURVAbrgVJ+kdU6u8EPSxalo3iCHoZ9bPvt3A4W+MEHtTpCwOEWbEGBSLjYKJcHxXmiM4cgvlwsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392643; c=relaxed/simple;
	bh=kqhQ7E6XNsfhK13mgz2eQ1qYFFJW94Cx/An4V+s7ot0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JY6+pN3aPQLqsbsPngHJCFCwmKFtA2PWvdosa5XTBEg+FUxHg5sYF73KWgD6ZPF8Ubblsfhh1fbaRCqb+d+ulBTd4zZ07Mu1peaRoh1X57xjlE/WbnA8lMPdFRC0KKg2a6tA/xOckt+dp9+lhGUmheP07jfTwvleKLxjLlHVBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UE9zjXvx; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UE9zjXvx"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-391342fc0b5so4948432f8f.3
        for <rcu@vger.kernel.org>; Wed, 23 Apr 2025 00:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745392640; x=1745997440; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9FSFz6hPA8yIIVKjBtqJNvelfYR0PkHGLGHajIq0U4=;
        b=UE9zjXvxEeaqAqZ6ttbMm6AIzoa0iHasiTRPPNM1UBbrj9Zs/D+fHYxLBc8oQbiO9Q
         +ZUW2JWKws/9N/bZA2N6RrxFCbuJY0D911CCh+jgn7nrUh1i7bchgDa+XYZwTkKaYF98
         Vg35VyvrR41iJeX4kQ8cCYWeXt2z8EmMCyuNLXjxJg7TlpNpOl6Mt2sgVfj3kz+ZUFGw
         eLf1RECDT61DyHcVxOcoZb4OBVkbhpADOjw6yGnnJeBlzIyLtz5KbeF1/ugOArQg/Tdp
         BLGzoprTMIy1+Jw9gE7yDvyfqanmJbskN+asDtjxrNPiOr3S+dEiWGavMFfYbcGv8Srl
         5VFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745392640; x=1745997440;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9FSFz6hPA8yIIVKjBtqJNvelfYR0PkHGLGHajIq0U4=;
        b=cnCH4XPyf7T/gN3BnkZAWCshtywNC8iq90RK0kwjtp2F4MAQ4boAaXoAfa22pyZ48c
         fkbQN8bq5QzpA3GhIG+bRUTlpY65hSWNOxP3TPtreg+5w5AToA8lk1Ojye/RVzs2YZmd
         vJmkGNY74+on9QN1DWQnpUxC+jMC3NSbDOgfruC7sfEVMn7DMlZ2MtBnMlJlHMsM0Xj6
         Dxl4IDF2SCq51MM2t7e4Ya1Xr5UmyDbXluwpYTke82OZ/b3ArjZ6/AvKu9UNrFNl7ltD
         4t238jPuq42K0xA+SpelzL3oBBW229cFce+Bk9snjcqYWm/VY1txsox7dCm2WL8FAsO1
         AqqQ==
X-Gm-Message-State: AOJu0YybxtYx1N6zzOYbe41Ffuy6Th5bNQEIIvXrQJaKl0l55vinnHVc
	3acLkCTDxl+4s8MURX0Cl9eD1cGRmcTPgesKccS46ERj4Zzkk4lHRcrYkPB7BYs=
X-Gm-Gg: ASbGncuZP/s07qIr8IF9vy4tWKAEJYgHrxuP5ZlCI0rJ1dk20I+C3CuU9pi4mT7OF1q
	Atinm2QQv8Q8HXITTBVwfGRwsUppxBsxcFlhbkufMwXcJMdd1ubklMAOtpiRqq3ScA3WaeN1LYv
	jKxgNm9iwDsH0bVrbfLLo78GX9p8o7ds5I/BSSADx1UUNKcTMTulZYPShNz/2PJD00qDR4banba
	dSHonuL6Dq0UGofAVyJqjbCJWWfdPoFdspUN9WmA/Jltw7ApivhCS5MtmsINZdJF2nHoWnNpaTR
	ueL1omBMU7e7n9piBjlRMPHEOGr5KwRp/PdGcTOVbHH1EA==
X-Google-Smtp-Source: AGHT+IG75nWkMPtfmQWEnyVLR8W+EPm/Woge3oyp9Y0AhFXGKNQ7yz8u7V613Rm7Wn8ktyZCF9+1pw==
X-Received: by 2002:a05:6000:4284:b0:39c:2678:302e with SMTP id ffacd0b85a97d-39efbae5c77mr15534765f8f.45.1745392640331;
        Wed, 23 Apr 2025 00:17:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa43314fsm18163398f8f.39.2025.04.23.00.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 00:17:20 -0700 (PDT)
Date: Wed, 23 Apr 2025 10:17:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org
Subject: [bug report] rcutorture: Perform more frequent testing of ->gpwrap
Message-ID: <aAiT_KWYN-gP-2MN@stanley.mountain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Joel Fernandes,

Commit bd57ec707441 ("rcutorture: Perform more frequent testing of
->gpwrap") from Feb 16, 2025 (linux-next), leads to the following
Smatch static checker warning:

	kernel/rcu/rcutorture.c:4586 rcu_torture_init()
	warn: missing error code 'firsterr'

kernel/rcu/rcutorture.c
    4576                 if (torture_init_error(firsterr))
    4577                         goto unwind;
    4578         }
    4579         if (object_debug)
    4580                 rcu_test_debug_objects();
    4581         torture_init_end();
    4582         if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
    4583                 cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
    4584 
    4585         if (cur_ops->set_gpwrap_lag && rcu_gpwrap_lag_init())
--> 4586                 goto unwind;

set an error code?

    4587 
    4588         return 0;
    4589 
    4590 unwind:
    4591         torture_init_end();
    4592         rcu_torture_cleanup();
    4593         if (shutdown_secs) {
    4594                 WARN_ON(!IS_MODULE(CONFIG_RCU_TORTURE_TEST));
    4595                 kernel_power_off();
    4596         }
    4597         return firsterr;
    4598 }

regards,
dan carpenter

Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C85E158DAC
	for <rcu@vger.kernel.org>; Tue, 22 Oct 2024 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588029; cv=none; b=kMVe9c69rHcMFITPuKxM0KPpdVNDEIFvhrY+P4vT5LbviLbxhoh5ZZayeyat4Jwt8tyi0pVSx83fYnSwq1RQsheZqu0Y8I9IyktybSegr1/YcaOkCYl73RhzndcOSn1HxTvC2Y6MLGr4sdbvYLU5kNcbpJ47kGbifnj+MGI4Qr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588029; c=relaxed/simple;
	bh=rZkY3vTEyqXE6c9rxGrtnQwiikv/bHh6tBRqCoYrv8I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H9zeQ1xnlJtx/MpfCWjqYKFCauGsrdrBDhFrym051HHeHk3T7eGNRxOsEPHN0UNYY9ylnaXxyaMmVuu3faGarDB99GAdaw/RvCyesjhAJquxlGSl1NrjHLBdBDIrCbh61bYAg/gBNrL78apHq3AqhS6WgmZ2UmwHUOP+MN90Puk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ap3rEvyC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ap3rEvyC"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d5aedd177so4443956f8f.1
        for <rcu@vger.kernel.org>; Tue, 22 Oct 2024 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729588025; x=1730192825; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9tI2EJx9zol4m7Awj3FsGVGLxK+1VTILmw1DIkv884=;
        b=Ap3rEvyCWclZn+BAh2W0Do9JuYUxKISOfCE98Wu6Fr/SXmlL8Q34CtKs1Oz27LUkPj
         bdVx75sdv1g/iCqHOQ/JqMensD/SwLrBkYm/80JmYrrmhpDZs9YDioZOlbFKw+PP8/XG
         gncK2dYkyZ+qRzUUzIqIY8lD/F4YP5aS1AFG+3Fd4k7xTODL43CuxYykk/rbaj+mUBtN
         y4F2ki1OLvq7v7oXwNTSDXe1RWrTlGTyYb25HMx7T96iToQO7DWI71LOnyyI7/+MjfDP
         4VLxYurW1i31vgd5nWdsTHLFMeh2GKGWB/I44Gn/l0fx5WnPbXkN3UgTgexdI6Jb47tD
         1Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729588025; x=1730192825;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9tI2EJx9zol4m7Awj3FsGVGLxK+1VTILmw1DIkv884=;
        b=pPgLVD1BLxwfgrPEl2R0qPQ4EvFr+0/N5Ir6UzzoBK6Tzn9Yt3ACHHaO7yIjh+zjq7
         Hh1F2iQW/+g2W6n0lu+ZSh/e5Wwg49v4esgNtkbXfEd1jxXMASpF4dGfUKpVs7XVzMZy
         DHSgXJ1dP/pGt4W/JueLf/CaHMv+oMGFHejOryVpPE6fFQaqqZ1GceEA4/MD3BorqncD
         nKYZ+xR+M0PfF4EY60Gcyi3lPUse53FZsoKIhUzHvhbGEgxUUJON4wjV8cXTjff/aFrb
         yzYzO9UTQ7DXy5VZs38n6mgfJ0riFjr4/2oF/XX4kLuTjmhDqKPIY0NyOsQHnxXuKv/o
         +0Tg==
X-Gm-Message-State: AOJu0YyN0oq7gsKbLrAJxMQZPGh8cINcq2yqwehACY6CQv/xmi0KWInl
	yKgGna5vqZqXf9k32O0r6L//FTlZS7O1ilctGWgFl4qqnTf98ozuttaGn9WJ5PM=
X-Google-Smtp-Source: AGHT+IGrlJB1fUzUyqZqzDCgILtm3+T7ZRJny4YoEIfDsGOdQyJcm72zLIN0ZYxroEMKt9To7yaqSQ==
X-Received: by 2002:adf:f8cd:0:b0:37c:d23f:e465 with SMTP id ffacd0b85a97d-37ef21c65d4mr1206984f8f.55.1729588025498;
        Tue, 22 Oct 2024 02:07:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bcc8sm6125232f8f.107.2024.10.22.02.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:07:05 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:07:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: rcu@vger.kernel.org
Subject: [bug report] rcuscale: Add laziness and kfree tests
Message-ID: <27bbe8bd-ef47-49a9-b094-89ab951e33ae@stanley.mountain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Joel Fernandes (Google),

Commit 084e04fff160 ("rcuscale: Add laziness and kfree tests") from
Oct 16, 2022 (linux-next), leads to the following Smatch static
checker warning:

	kernel/rcu/rcuscale.c:1215 rcu_scale_init()
	warn: inconsistent returns 'global &fullstop_mutex'.

kernel/rcu/rcuscale.c
   857  kfree_scale_init(void)
   858  {
   859          int firsterr = 0;
   860          long i;
   861          unsigned long jif_start;
   862          unsigned long orig_jif;
   863  
   864          pr_alert("%s" SCALE_FLAG
   865                   "--- kfree_rcu_test: kfree_mult=%d kfree_by_call_rcu=%d kfree_nthreads=%d kfree_alloc_num=%d kfree_loops=%d kfree_rcu_test_double=%d kfree_rcu_test_single=%d\n",
   866                   scale_type, kfree_mult, kfree_by_call_rcu, kfree_nthreads, kfree_alloc_num, kfree_loops, kfree_rcu_test_double, kfree_rcu_test_single);
   867  
   868          // Also, do a quick self-test to ensure laziness is as much as
   869          // expected.
   870          if (kfree_by_call_rcu && !IS_ENABLED(CONFIG_RCU_LAZY)) {
   871                  pr_alert("CONFIG_RCU_LAZY is disabled, falling back to kfree_rcu() for delayed RCU kfree'ing\n");
   872                  kfree_by_call_rcu = 0;
   873          }
   874  
   875          if (kfree_by_call_rcu) {
   876                  /* do a test to check the timeout. */
   877                  orig_jif = rcu_get_jiffies_lazy_flush();
   878  
   879                  rcu_set_jiffies_lazy_flush(2 * HZ);
   880                  rcu_barrier();
   881  
   882                  jif_start = jiffies;
   883                  jiffies_at_lazy_cb = 0;
   884                  call_rcu(&lazy_test1_rh, call_rcu_lazy_test1);
   885  
   886                  smp_cond_load_relaxed(&rcu_lazy_test1_cb_called, VAL == 1);
   887  
   888                  rcu_set_jiffies_lazy_flush(orig_jif);
   889  
   890                  if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
   891                          pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
   892                          WARN_ON_ONCE(1);
   893                          return -1;
                                ^^^^^^^^^^
   894                  }
   895  
   896                  if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
   897                          pr_alert("ERROR: call_rcu() CBs are being too lazy!\n");
   898                          WARN_ON_ONCE(1);
   899                          return -1;
                                ^^^^^^^^^^
The checker is complaining that we don't call torture_init_end().  Should these
do a goto unwind?  Otherwise we're left holding the fullstop_mutex.


   900                  }
   901          }
   
   [ snip ]
   
   938  unwind:
   939          torture_init_end();
   940          kfree_scale_cleanup();
   941          return firsterr;
   942  }


regards,
dan carpenter

Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CA21B0F3E
	for <rcu@vger.kernel.org>; Fri, 25 Oct 2024 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839494; cv=none; b=MY3Pnojv2mpr0EFcgCinlEviW9jz7Y16Ey5aBFuYkUrIdl8fCFFenoGLvr98ZDAtUhwTSYBEeD6mXMxIgM5ESJ7wigi3xjZiDhxc5dlO3ZVW+MxB8wNLn1KwuxLCJOXwZqwrpL5uckUKdOIYh47Gs4c/o2qofCVdlzqt/YhMv50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839494; c=relaxed/simple;
	bh=sBTXmI6NZgdBE3MLizMmB4sLy8PV3GeBa7CDd4wgcy4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ncLaswUnkSbuNsgMFzgVpXolZUXUpVHBDwY6BmrQal/zx6IttQ6+P5QN5vquiE8xZt4pC7992G8LuUn5mAR3kTqbDnvNA6yLGzHJtlD621S+7SAMGne1P/m5GvNqpC5sn9y+hWtcXmiRg0MR8xMdjK8wDOBWzvYUCL/moMaLVH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=og/WxUJ3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="og/WxUJ3"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d808ae924so1194804f8f.0
        for <rcu@vger.kernel.org>; Thu, 24 Oct 2024 23:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729839491; x=1730444291; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3LzRSuqFUNNIls06aLLw3N1E++PGjrYT9igAcSyaqw=;
        b=og/WxUJ3WjWjBUiBzwbMzqI9IuiqLaNm5+aw8Fo3jo/hB3NFOFQCgxKYB49VuqzDQK
         JbKrRucgmHQk/JBLD60dWcqOsbmBrc0LF1YsrIn0PE5PaGKEYd+L0mF3FWEBhvD9ZzwS
         JIws6rxCs2Um0+fnpBXOVeK6IH0ApGBsRincf7mlQgwgd7fcBefLnl2vdqQ9Zc1rEoLa
         bNietSi+WH4Jv7U//+CactFuy6UYoedD+sUBqYpSvAA/bCnj8S/2LN7WfIPHjB3CkkN1
         RlF2lViy/KYHxwY2Scs8KoxTJpHYSsRHH4vkaeYP+DJCdEBdIxONbsJAfBYaxD9HzQu5
         wmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729839491; x=1730444291;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3LzRSuqFUNNIls06aLLw3N1E++PGjrYT9igAcSyaqw=;
        b=d2O3gTBrEKyR6XcIuSLMjNODA/kbXZTdOxDKT8GrlF5FtkmzAfd1Kq7ERSnBvLiaJ4
         5uobW11UzMCGMkVI7iCqrqCpXeTRyowtfT00kQPIRtGwUcpn1RPV02GqUH9wipy8Ur/t
         ps+sBx6bW06mmdsgF9nD5vaUOwp5eFKnLytLY6O2P+za1Mmq0oXqUTQttwp+m5RVuwvw
         cMwoSHdHSVAc2d2cwtreIrgTSKcySZJAi7+cvwjGXuLKHtzWTEAHcgSh9gOFivgXWhp6
         K0d1943/8kGEELRfjV4TESWQy2p+PRGA4plGLJYAebBnedflHzaaBpAKUlEVi2a0V9hg
         HyAw==
X-Gm-Message-State: AOJu0YwCuLc6RoiFPAPVrtuZ8oI6tKyXhmPTiqXNR5nqRNVc78rOYK+U
	nkKdENupfvSIyEVUpnwOByv9gLxJZacZVYf8FW9NbTovfFAia80/hhSEYOdAIcmJGh6W9yqX7ln
	iCK+LqA==
X-Google-Smtp-Source: AGHT+IFOUcg0o8x+V8MO/OT9IJx0xRi4+WOeNrizJQmPZtw76liyIhfSDJyY1kDogHEQxRhVwLBKKw==
X-Received: by 2002:a5d:46ce:0:b0:37d:476e:f110 with SMTP id ffacd0b85a97d-38045882607mr3262640f8f.34.1729839490270;
        Thu, 24 Oct 2024 23:58:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b47a41sm751945f8f.52.2024.10.24.23.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:58:09 -0700 (PDT)
Date: Fri, 25 Oct 2024 09:58:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: [bug report] refscale: Add srcu_read_lock_lite() support using
 "srcu-lite"
Message-ID: <663547f8-3126-453d-8f9e-f9ce252d43c2@stanley.mountain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Paul E. McKenney,

Commit 1e07186d7377 ("refscale: Add srcu_read_lock_lite() support
using "srcu-lite"") from Oct 15, 2024 (linux-next), leads to the
following Smatch static checker warning:

	kernel/rcu/refscale.c:1151 ref_scale_init()
	warn: inconsistent indenting

kernel/rcu/refscale.c
    1141         for (i = 0; i < ARRAY_SIZE(scale_ops); i++) {
    1142                 cur_ops = scale_ops[i]; if (strcmp(scale_type,
    1143                 cur_ops->name) == 0)
    1144                         break;
    1145         }
    1146         if (i == ARRAY_SIZE(scale_ops)) {
    1147                 pr_alert("rcu-scale: invalid scale type: \"%s\"\n",
    1148                 scale_type); pr_alert("rcu-scale types:"); for (i = 0;
    1149                 i < ARRAY_SIZE(scale_ops); i++)
    1150                         pr_cont(" %s", scale_ops[i]->name);
--> 1151                 pr_cont("\n"); firsterr = -EINVAL; cur_ops = NULL;
    1152                 goto unwind;

This looks like you pressed the wrong button in vim and it accidentally jumbled
the code?

    1153         }
    1154         if (cur_ops->init)
    1155                 if (!cur_ops->init()) {
    1156                         firsterr = -EUCLEAN;
    1157                         goto unwind;
    1158                 }

regards,
dan carpenter

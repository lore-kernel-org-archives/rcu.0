Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB57268696
	for <rcu@vger.kernel.org>; Wed, 23 Apr 2025 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392804; cv=none; b=fB6i0TBvwJWiv8qhqGleww1MZMZUZll2kbglySZtSH542yrvWkkEhIIEwA+IM6O6vqshEcTudh40KF5IvfMSCOuR9KWQEWccf5Be9laeC+8fZljKB+C4QoCqN18e0yTK8s4o6jcB2r+SeYMFBieJifKKW24t8kpNA6t8lYE/OxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392804; c=relaxed/simple;
	bh=smmYDufsjbjBjDWV40rbRy2E3PK3vB9L1/DXtwflF3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TP2zt3iLT2prfymaXe1Q/q2trMyMocPawKckzFie7G0/aFTl+6yvLZY3wuQfF7i2WMrUJEaElO0hY8HuOjxZ1TZDxrkW19rJH41DSQ7bybeBYIeoVsbXG91eOyjVm1fXxxfSc+vHVcLJSrnHKR/gXGunCUePC29wOkSrj8YZuuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fKT50J7K; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fKT50J7K"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so52444625e9.3
        for <rcu@vger.kernel.org>; Wed, 23 Apr 2025 00:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745392800; x=1745997600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OR74dVzjrf/AK6zC6N0hWMl/Ho9XyWEuqtCVC7UQZyE=;
        b=fKT50J7Khu1l8egaifuglXmh571K6/rrpgmbPBvfklBmRbrz4iv/sJ/nKsAYCS64l4
         DyGk/EGrHXQFtqHpeCaiob5je+pr2y1obkMUntxllq7EmmTbwOafy+wih3wb9RwGAaiD
         6KsPhi6d+CE9o/74wzfYeLwW0kFzmh0UbjJOHQayVsgyw3FLlUvEfICQSDRoE9HLIT0K
         FMM18Kw8Z9XSpt+Nb+++dOn/hVuVj30VaQ2juO5RCjhlXy9znlhC+mBZXO+8VpxJhi4A
         eZW9yiEWotTbkGSIoeZncei/Y2YBx8IHAd2ejzIzF7+cErrXvJSYLbSa5DM538LhrEuH
         eXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745392800; x=1745997600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OR74dVzjrf/AK6zC6N0hWMl/Ho9XyWEuqtCVC7UQZyE=;
        b=lUBT6oc01vigYfIkE3aLVjjX4oKGNEWnvxml1PRRkxMjJzrKC7VHffCvG8yxw8IhMp
         2r8UWWjkBdu3PxUvzUlZJMGDIXPiJ6+f8+Kb4OnAsffIGcWpJBOvuC9r2S3XHLw2jV2p
         yOb6WsbMEVtI3UE+pEvbfegGidPtohdDNi+KD1AYN3opGw1JBrCc4PUPZNkNOShvj0Gi
         xk9duxmSXXBs5jpevLen7EcguSknl/kSCwg/ICMEoLM49yIp4RNSbHjdez6UlTMo6G9t
         vmYfMIhtRZV3h3lo2QS0XBE1Fpo+Qmyh/0uap01KtQUMc/BGU4tTUFuOvUO09qOIJZA1
         M1/g==
X-Gm-Message-State: AOJu0YxOO9iAsQUyWPh/oi+1UFSrIX6/GLiYYlfIwMHi83nJ7xuU8Zr3
	DOfpvlEqW8INK8Vja0Z93FqkzY/WTRTgZVq8padI3qFsh03vMFFA4PODRCnT6wI=
X-Gm-Gg: ASbGncv8XNhYBg54JxQYqoIYd159E3ai99OMZgmR/+FXHj2VAn5KQfBHPx8YwrB7N3o
	j+0U5G7ptcvdxaK2gW6sll420QVjPhwG9fzez4LYnf2psX4annl0QbQAL8HvVTHQ1QQXKe3fAkJ
	o3Db12Qk9DUM14O8n48U9t2N7HPAxzcqXP1J1OxYgHONfT9+ISzKuGZ51qXKA/EUNtohiEME+Dx
	FQGYXUJ6r0hQz4pQJdiniISnp5y0enp/w6JufBXlolL5ISaVGEc95YMc8PMYa7bOv1a8GFPYBYn
	kDvWv64ckf3J1n37EvWker57EybomOFLefxZrtq72KNJMg==
X-Google-Smtp-Source: AGHT+IGllPjrDJ4rOdh6p2HyX5shxZf3S8XhQU7VAbCuHt/Lu5HC9lUJzLZnlo7BYbpIePLV8jHUvw==
X-Received: by 2002:a05:600c:c87:b0:43c:f616:f08 with SMTP id 5b1f17b1804b1-4406ab95a56mr166408495e9.8.1745392800506;
        Wed, 23 Apr 2025 00:20:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa493207sm17796448f8f.79.2025.04.23.00.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 00:20:00 -0700 (PDT)
Date: Wed, 23 Apr 2025 10:19:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org
Subject: Re: [bug report] rcutorture: Perform more frequent testing of
 ->gpwrap
Message-ID: <f8669b6b-63e0-454d-8a58-09043015bc61@stanley.mountain>
References: <aAiT_KWYN-gP-2MN@stanley.mountain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAiT_KWYN-gP-2MN@stanley.mountain>

On Wed, Apr 23, 2025 at 10:17:16AM +0300, Dan Carpenter wrote:
> Hello Joel Fernandes,
> 
> Commit bd57ec707441 ("rcutorture: Perform more frequent testing of
> ->gpwrap") from Feb 16, 2025 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	kernel/rcu/rcutorture.c:4586 rcu_torture_init()
> 	warn: missing error code 'firsterr'
> 
> kernel/rcu/rcutorture.c
>     4576                 if (torture_init_error(firsterr))
>     4577                         goto unwind;
>     4578         }
>     4579         if (object_debug)
>     4580                 rcu_test_debug_objects();
>     4581         torture_init_end();
                   ^^^^^^^^^^^^^^^^^^^
Also:

kernel/rcu/rcutorture.c:4591 rcu_torture_init() warn: double unlock 'global &fullstop_mutex' (orig line 4581)


>     4582         if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
>     4583                 cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
>     4584 
>     4585         if (cur_ops->set_gpwrap_lag && rcu_gpwrap_lag_init())
> --> 4586                 goto unwind;
> 
> set an error code?
> 
>     4587 
>     4588         return 0;
>     4589 
>     4590 unwind:
>     4591         torture_init_end();
                   ^^^^^^^^^^^^^^^^^^^

regards,
dan carpenter

>     4592         rcu_torture_cleanup();
>     4593         if (shutdown_secs) {
>     4594                 WARN_ON(!IS_MODULE(CONFIG_RCU_TORTURE_TEST));
>     4595                 kernel_power_off();
>     4596         }
>     4597         return firsterr;
>     4598 }
> 
> regards,
> dan carpenter

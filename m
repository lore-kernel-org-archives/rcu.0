Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589A6C6FA8F
	for <rcu@archiver.kernel.org>; Fri, 25 Aug 2023 02:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242150AbjHYCuy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Aug 2023 22:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbjHYCuW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 24 Aug 2023 22:50:22 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EEA1FCB
        for <rcu@vger.kernel.org>; Thu, 24 Aug 2023 19:50:20 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34ca22e3b3dso1609985ab.3
        for <rcu@vger.kernel.org>; Thu, 24 Aug 2023 19:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692931819; x=1693536619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y07oxKzyD6NouQNFuvP7iMeRumD3C6SmckUNPVdKHuI=;
        b=Uvn0tCpDS7x4CpqXBSraVlmBEZseQr0pQXSHG+VSJNKTtYYykh44u0IY4cI18f+6iO
         ET2BOvuye9QdRqesi7FAufkxT4FYMQNd28iDXCMStKdSD8p1MLO91HNiAlQwGf2IstLQ
         8dObiLX1f/R57wEuNHjH6805Jt9ZXvPv6EmVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931819; x=1693536619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y07oxKzyD6NouQNFuvP7iMeRumD3C6SmckUNPVdKHuI=;
        b=bc3R/oY2KILmeKEO6mT/p7uMhk9C/z9yx25ELWN7AnowI2WW2scoQwlpiWd3a9eHNu
         YVHp3ppN8PcLYRLL31RgCbLRVgaJvjLk8KqOpYb5UQewCNq6XWNZSXQaeYPpWdW+pFI+
         kd9jyVt8fPtYwr1mOpdPxvXQ1by7HaRQ2Y2ZDfpcD12r7WtP2+L9g6+lxzk7IJN4QuLq
         gI1x50flQq+3U+GT8BQqm2ZzdgdPrUqLhNlkSveBZrlIpnJV1IKAtWvfeNWHyBbYe5ey
         6OiG7u6k4uLJxhY0ZbVDzMcK6YSJSkLS+PT61VNNOL/yF9ap3izow4bhJFkwPncX0qOX
         8wKw==
X-Gm-Message-State: AOJu0YwLCjFb4j+Xn8AqkAMelm3/IpitU40C4gwzT9g7IQ5sNcyBBi1J
        OkGJSIH1oLlsclPfjsAnqyB9SohguOgmkaWWpfU=
X-Google-Smtp-Source: AGHT+IG1y7uufh0ZqghTjwd9fOJmupY196QtHzD1FH3ku/72RUHiNwHSxQVydE0d+2Mb92Q7YhpX8w==
X-Received: by 2002:a05:6e02:c74:b0:34c:b3aa:b0aa with SMTP id f20-20020a056e020c7400b0034cb3aab0aamr6926435ilj.23.1692931819566;
        Thu, 24 Aug 2023 19:50:19 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id go7-20020a0566382c8700b0042ad887f705sm249214jab.143.2023.08.24.19.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 19:50:19 -0700 (PDT)
Date:   Fri, 25 Aug 2023 02:50:18 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rcutorture: Can not Disable RT throttling
Message-ID: <20230825025018.GE4008060@google.com>
References: <CALm+0cVvHb=Fe8kseVLesjS1d=579c7Bn5hxdiqyzBp5Z7SugA@mail.gmail.com>
 <CAEXW_YScFnFG0Y1NgFS7KGS6s9CoXJ3ZQB++6udyK38mcJ=1xg@mail.gmail.com>
 <600e1ab4-059b-4b4e-9db2-2c56ac557d3b@paulmck-laptop>
 <CALm+0cUrwYAQ=frj+S=N8s8Q4KYV6JWoU0+2E-NvaqEoFcMC7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cUrwYAQ=frj+S=N8s8Q4KYV6JWoU0+2E-NvaqEoFcMC7g@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 24, 2023 at 10:30:37AM +0800, Z qiang wrote:
[..]
> > That would be difficult in built-in rcutorture testing due to the fact
> > that there is not much in the way of userspace.  I suppose we could
> > invoke the sysfs handler so as to mock up a userspace access, but that
> > might not be the most robust approach.

Yes.

> Does it mean to use filp_open() to open sched_rt_runtime_us file and
> write -1 through kernel_write() ?

I am afraid so but that might become hard to maintain in the long run. I
prefer exporting the necessary functions from RT to the kernel and just
calling those.

thanks,

 - Joel


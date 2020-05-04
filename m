Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E1DC47257
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D8B2075B
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJSWK3Fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgEDMoV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 08:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728875AbgEDMoU (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 May 2020 08:44:20 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8B3C061A0F;
        Mon,  4 May 2020 05:44:18 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w20so9539215ljj.0;
        Mon, 04 May 2020 05:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/F4NjM3U9kxbREFxopp8An9SFYvql40/vSs62JTddHE=;
        b=BJSWK3FxnlFrT8zrKm7gs/qkb/VjtJ4Cg44AcbRaZx+gew5JuAWmu19nOK/F6+DBKw
         k0HrT9+yimSfjSuSS+TlkFrVJOXsoyr7flhNKTmUgkdfavmFmRgiqmEUQdbEjUhu1gJA
         3wQKEJ5WyYHqlUFdcQpzZQwfMfYHnt0rv5idAsn4EMGzeM6ZLfsoBlMMxQhIc1mSvRpL
         qYWpwG1KQ4YTtOUZ7plCHFWxIQOWivDOpyfi4b9orOdkeHtsQml8wuiVy9YUszcRTpkO
         jwLm9b9ERAByJ7z/x2tjeLFIJShIzDbox/x3Iro89LXGBFlwqZRWN44iShMrlTD0JJMV
         Y21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/F4NjM3U9kxbREFxopp8An9SFYvql40/vSs62JTddHE=;
        b=erzknn/UR7i2b72P1s9Fv7JrU+Ktu5+ktYnTOcbUABQBV5P+5vCSLgKDn8qp+Uh36Y
         Hctk7Jm/fExLakmTAdPSPc+FJ6cPDQKsIhss/De0Sn9Q7YSTGnn0P9kSN+IK8876zBas
         iCax+9rXvCMG0NnwQGbqEWK9vs/GFdWUJlVXkUz8DwUDxDmPxous2f/FFWt9irHW9oXU
         6l5N1EldO0haRnnwI3FNYf9B/i5WHlCMf4KMptnGxegjj1XxojlkEeyvXQ74U6WbyAC3
         MCERr52CM7hcO3dfNKyQxeEf6ttkwGV68mW+T8psU0Ff5dPGsSZn8XSHT0ciB/Lm0vR2
         eDnw==
X-Gm-Message-State: AGi0PuZ+TEY74FTvGkUSYzjdNU+pzY3S5P5oXtkpcR/PgoHk0RchX0fO
        hn32USekBykDBta0UB1NBtc=
X-Google-Smtp-Source: APiQypKAhhmzg+orF2c36cc8VXnxMP8aj3luTgAUh+eKp3ptrapFXQnwOlWT+Bw32IVhxgPSHb697g==
X-Received: by 2002:a2e:b162:: with SMTP id a2mr10125818ljm.25.1588596257115;
        Mon, 04 May 2020 05:44:17 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id n14sm9553004lfe.31.2020.05.04.05.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:44:16 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 May 2020 14:44:14 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 10/24] rcu/tree: add rcutree.rcu_min_cached_objs
 description
Message-ID: <20200504124414.GB17577@pc636>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-11-urezki@gmail.com>
 <20200501222524.GA6283@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501222524.GA6283@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 01, 2020 at 03:25:24PM -0700, Paul E. McKenney wrote:
> On Tue, Apr 28, 2020 at 10:58:49PM +0200, Uladzislau Rezki (Sony) wrote:
> > Document the rcutree.rcu_min_cached_objs sysfs kernel parameter.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Could you please combine this wtih the patch that created this sysfs
> parameter?
> 
Will combine them.

--
Vlad Rezki

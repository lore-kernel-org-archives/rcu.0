Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4C5C433F5
	for <rcu@archiver.kernel.org>; Tue, 28 Sep 2021 00:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934CF61181
	for <rcu@archiver.kernel.org>; Tue, 28 Sep 2021 00:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbhI1AQD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238253AbhI1AQD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Sep 2021 20:16:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E957C061575;
        Mon, 27 Sep 2021 17:14:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id r7so13102504pjo.3;
        Mon, 27 Sep 2021 17:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dSWE00mO2wcQAAFzaJB7Le1X86LxIQ4JP4qQH+pzMN4=;
        b=gzMUIeFD99KrmEh5i1yVmUTKt+KaH12opoE14aJcNmeoOZ739/MqW4Z2daspAvKAEL
         tmJCPn6B/vlGR/obzaI3/DNOJwlCN35b/N/GXa/f2zMVoLmHBmAZSxwVRhC5jSUwKmUZ
         BBptlo7I9yvCSjw+qFeb7nMPpKlVIPbp087MHAE8jR5iKxvQSq2qA3JivkfHi/Gf+75i
         LCr52tbZiedDHSk5VF36GVOG3wHM26PxJ0bxzTEDY8/dhptGt0WW1pgZbKTgqYqe5gFR
         GzmfBwHenr6FIRWN6aQzW1OLlINatnE/wUGm6aEkEFllpZrHdsJIjT5YsLZ3AoM79qmY
         DuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dSWE00mO2wcQAAFzaJB7Le1X86LxIQ4JP4qQH+pzMN4=;
        b=Cr1Otc+Tv7vSzUZrXZOIU2294LT5RxxnXVxkOXjtFnKU/a7V0YaSrxwZiQvc5TqHw8
         TeWU0XXN19PCtpAH3AzJ1x8N0G9dcNO5m+6dRt70LxkZ0inmnW7voUdoRCU6EYkxQncq
         ucu5acgbEJE60hBWvwvkQkg6z6D2MONj7k4KWW21sb2f1yykarlNeonrVoEU1blvcI0a
         ROI12/akJxQ252Og/gMP89tt21vlAP71Z2D+z80j9cFotzUTa/i2yahRjN1TbEcpcAqk
         cEvABhK8rGo3HpTjSSFDTql0eKfGxYqk17moXeZTKbgxUm2Vr2I5sR00FwQpJ0zCnFW6
         NKQw==
X-Gm-Message-State: AOAM533aFoTPZdTG6LZMw3drerllGfCUoUhHiUsy17vzoJVH3J6FXdBB
        8CE9+qpGcRF6nXQwU1N0XFw5y1K8ym4=
X-Google-Smtp-Source: ABdhPJxd0UnbrX3tWTOIpQZPaeWwOpO9oVsOcokZ/126/xYtPBtBGD4m1R9vO0mHPXSITqa4tQ49IQ==
X-Received: by 2002:a17:902:e2d3:b0:13e:389f:87c1 with SMTP id l19-20020a170902e2d300b0013e389f87c1mr2377681plc.69.1632788063931;
        Mon, 27 Sep 2021 17:14:23 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id m7sm19061366pgn.32.2021.09.27.17.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 17:14:23 -0700 (PDT)
Date:   Tue, 28 Sep 2021 08:14:15 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] kernel: in_irq() cleanup
Message-ID: <20210928001415.aqrskdgzox6iwxmh@mail.google.com>
References: <20210813145101.85782-1-changbin.du@gmail.com>
 <20210915003232.nvarqpjnvyutc46o@mail.google.com>
 <20210915153938.GR4156@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915153938.GR4156@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 15, 2021 at 08:39:38AM -0700, Paul E. McKenney wrote:
> On Wed, Sep 15, 2021 at 08:32:32AM +0800, Changbin Du wrote:
> > Hi, could anyone pick up this cleanup?
> 
> If you send the RCU pieces separately, I will take them.
> 
> 						Thanx, Paul
> 
sure, I'll do it. Thanks.

-- 
Cheers,
Changbin Du

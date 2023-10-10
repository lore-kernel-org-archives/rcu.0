Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E578BCD80DB
	for <rcu@archiver.kernel.org>; Tue, 10 Oct 2023 14:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjJJOHI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Oct 2023 10:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjJJOHH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Oct 2023 10:07:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E37AC
        for <rcu@vger.kernel.org>; Tue, 10 Oct 2023 07:07:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32615eaa312so5198438f8f.2
        for <rcu@vger.kernel.org>; Tue, 10 Oct 2023 07:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696946824; x=1697551624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvVJSuploogbry/5+vlY4UrajqKjgEpimkSZQtt9RdA=;
        b=MoYa9HLK3DiNhFgqiuy1/TJnRYjQFcLlxiO5QxgEyBoesQOq8VJ8G2/plTVqi817HZ
         3W0RGQR4meFN+IlGu+nMo9fQLQcB5WxrotkfhaCW0ieCC33yHpDK4MhAu9SlXPKRMtFg
         szoCy/I7kqZwZX/QYFZV7Znn+qEIox9xwgfnlNSVPkl5NfGKnG8XnQQvPiREVQNLsQIq
         XrhERXbpaLKwOeKGohOTLMx7iyH+EXDHXjal88Y4fnkQEDTw2ynwzFEF2bQiTIWYHRQE
         qgnAyX2+7K81XG1VcC2YmwUGTSH9JctgJjlO7syIrdCgMl1Wh1S3VpMNuYd40/hcmGa4
         bSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696946824; x=1697551624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvVJSuploogbry/5+vlY4UrajqKjgEpimkSZQtt9RdA=;
        b=Nv/YABfckVFzgU6dFshYxD8eg0ABTyw3sUbIQlO6YfCyEtBmO/V4qGiLLJxKv7n0Bb
         lNdbLhLRouenXsVoMXgsNaT/d2CqKfLvvOOsVNySJFUkjlbb9813KjU0mvE9GvOY8m1m
         kdXjoFAmzDyaZO1ZUjuNQuZ2+tD7NsJiZX1dk37Q/KFlTry8ahGpe8i735SMfVS/dT59
         /Gz20B59TESzOj7Hxlv3V/ol9wC0wtx3vCOarjwZvI7jFj3pDnLisA23AcVEoCF1xd1i
         8kX2NSnHbyxqbg5uAgg8+UGTGscrVNbm5SvxFkzRJjq/XSQdR4ERJcU9IkqqLBMskeJ/
         z+Lw==
X-Gm-Message-State: AOJu0YxBqSnNT8eeJ9l01Oy4Lw6kYBmc4VNoTpvGGHJqn0Ix/Zn4OdRW
        gIv3emhw9ZpzCkguAMynVU1Q3w==
X-Google-Smtp-Source: AGHT+IHcACqg2+6E7sTuSYE5WTfIIip9FCFriO7r1cIcXjkotEr9Bzs9OQ65b0qZMYS5EgEM3sjw6w==
X-Received: by 2002:a5d:568e:0:b0:31f:d2dc:df26 with SMTP id f14-20020a5d568e000000b0031fd2dcdf26mr15707129wrv.28.1696946824289;
        Tue, 10 Oct 2023 07:07:04 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b003258934a4bcsm12798664wrp.42.2023.10.10.07.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 07:07:03 -0700 (PDT)
Date:   Tue, 10 Oct 2023 17:07:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 23/23] locktorture: Check the correct variable for
 allocation failure
Message-ID: <beaba092-8545-43c9-9b65-6386f718cb01@kadam.mountain>
References: <20231010115921.988766-1-frederic@kernel.org>
 <20231010115921.988766-24-frederic@kernel.org>
 <97ecfb49-e500-45f4-86bb-769b2d32e91c@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97ecfb49-e500-45f4-86bb-769b2d32e91c@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 10, 2023 at 06:55:40AM -0700, Paul E. McKenney wrote:
> On Tue, Oct 10, 2023 at 01:59:21PM +0200, Frederic Weisbecker wrote:
> > From: Dan Carpenter <dan.carpenter@linaro.org>
> > 
> > There is a typo so this checks the wrong variable.  "chains" plural vs
> > "chain" singular.  We already know that "chains" is non-zero.
> > 
> > Fixes: 7f993623e9eb ("locktorture: Add call_rcu_chains module parameter")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> A name change to increase the Hamming distance would of course also be
> good, though less urgent.  ;-)

"Hamming distance" is such a great phrase.  I'm going to use that every
time I complain about confusingly similar variable names going forward.

regards,
dan carpenter


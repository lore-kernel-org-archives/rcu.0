Return-Path: <SRS0=FT7R=6V=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7B6C38A24
	for <rcu@archiver.kernel.org>; Thu,  7 May 2020 17:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A6220735
	for <rcu@archiver.kernel.org>; Thu,  7 May 2020 17:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd+juih3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgEGRev (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 May 2020 13:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726761AbgEGRet (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 7 May 2020 13:34:49 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E94C05BD43;
        Thu,  7 May 2020 10:34:49 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so7195371ljb.9;
        Thu, 07 May 2020 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JblqVDATbZ3VyIvCxA3kiBa3Vh0aMkYFRj7d4ibwanQ=;
        b=Qd+juih32c1McgBhlvcJ2zTUWqnpu3lhRsglBhog+dnClNU9YdNIfNNRv28DVjhEXW
         ev/++sR1sVi6W6dzuunGz4k4nQCt2AZML6YrVQkuvXX09nGoPtD9Qj4EYOk3Cf+ytlkL
         jnpVTg0Hr+MU0yTuCZccX29G/3pxt4BeD8x+ymUe6VilPzUq7vCc/m7eGgdBlPiSEHpl
         iskCWvu/D/8jJCPyKCygywV+KtotbPCmXpMxBsoEd5nvF/utgJuFmqyPTJHDvudyx8o6
         rasH6PrgKDbK2pyAP5DWo1u6F9iDtrudIew76gE9w72MR7A6Dnc2/LRqRJLuWb9lZptm
         VRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JblqVDATbZ3VyIvCxA3kiBa3Vh0aMkYFRj7d4ibwanQ=;
        b=RfcOAL1u1kaz5eJ8hFUuoH62My3+bYTZJg6AquiirWVDJtnCczoUnoSON0okpsZkb9
         ZusVNadILC/qm7agTna7woPaZQlCu4vSVeD/tAGvZ//MaWf3h50aM2xpoXEfWF8uAHM6
         fWcclO78JG5ZbS5KFppmZAJxKZmI2ey1/pZ3StduS3sb8b4z7o3Bf6kxgQCkQKjd7ol8
         pGVHzqQVLXn9fEujVZqEBtSFYTYXKnlJtER5TGbN1XX5Q+46hPsARPdF+LQJaZ35AWUN
         +NRspHT41OuNSuJdADehuu0TVCgvr4W4qDcCjivxUXB/RbQfCez1yYWzVOI2DDt/SxCV
         UXAw==
X-Gm-Message-State: AGi0PuZiIbPjcaxHL3tWhGySc79RFekide+FcP49Y0ooEL47LbFxTQBe
        PxLdzsJRBcMhMx5Ot6M094c=
X-Google-Smtp-Source: APiQypKqpQXM/zFtg4moCRPqI6xRMf3DiK/mjpH/2Y+LT9h9tt/th8WCm3OO36y1LBZY0aJkUaR0hg==
X-Received: by 2002:a2e:a365:: with SMTP id i5mr8938424ljn.293.1588872887741;
        Thu, 07 May 2020 10:34:47 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id i3sm3650533ljg.82.2020.05.07.10.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 10:34:46 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 7 May 2020 19:34:44 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 21/24] rcu/tiny: move kvfree_call_rcu() out of header
Message-ID: <20200507173444.GA12883@pc636>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-22-urezki@gmail.com>
 <20200501230359.GH7560@paulmck-ThinkPad-P72>
 <20200506182902.GA2570@pc636>
 <20200506184548.GE2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506184548.GE2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > 
> > Please see full log here: ftp://vps418301.ovh.net/incoming/include_mm_h_output.txt
> > 
> > I can fix it by adding the kvfree() declaration to the rcutiny.h also:
> > extern void kvfree(const void *addr);
> > 
> > what seems wired to me? Also it can be fixed if i move it to the tiny.c
> > so it will be aligned with the way how it is done for tree-RCU.
> 
> If the mm guys are OK with the kvfree() declaration, that is the way
> to go.  With the addition of a comment saying something like "Avoid
> #include hell".
> 
> The compiler will complain if the definition changes given that there
> has to be somewhere that sees both the above and the real declaration,
> so this should not cause too much trouble.
> 
> > Any valuable proposals?
> 
> Otherwise, yes, the function would need to move to tiny.c and thus add
> bloat.  :-(
> 

OK. I will declare it one more time. Indeed if it is changed, the
compiler will emit some errors. Also, i will add some comments why
it is done.

Thanks!

--
Vlad Rezki

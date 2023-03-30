Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1769C761A6
	for <rcu@archiver.kernel.org>; Thu, 30 Mar 2023 15:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjC3PjR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Mar 2023 11:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjC3PjQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Mar 2023 11:39:16 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473811985
        for <rcu@vger.kernel.org>; Thu, 30 Mar 2023 08:38:48 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id x8so14261406qvr.9
        for <rcu@vger.kernel.org>; Thu, 30 Mar 2023 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1680190726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mb6S13eHFePFzWW7RsFsa0Nq8URmHY2ItiKe+00J7B4=;
        b=J17WW/DDhUJLo3fLGNzQCLbDEKgzDMnQMxvsLs2L2MczWrITKGAuRcUmlYUbv8jJ2l
         FVwNzvnE2YIdb0q9KELWPqrU6Q0Q4aAEcuYYEcGpBPuswDmyxIf8LrBmeKXXmJUQAX77
         QGw4FwFEb90E23y5J3Aq2A/2wR56yQ1H3+iDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680190726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mb6S13eHFePFzWW7RsFsa0Nq8URmHY2ItiKe+00J7B4=;
        b=ZksNSSJ3yRhQB3haz3fgHN+6r/Ezmv+KWTmQ757oS0KHFhGNgKbbKhNmUuH6kyeisN
         TviZe7qeMoOjgxy29GIgA/k6Tb8diT1lGIXlo0b4fz4Tmf9Iu67wVKlzmNcUJ96Hq2lS
         FLYExECljihaMFsDwr/75fJAxS6CNtnJk5BtHw7ZtKZJSJ1cWBb5FaW31plaapUVqMNp
         SYWtB5uJfXyzwLNKItn85fpgLmr4JWQVCYiuvvmZavBqHJXPP5lOb8Fgkxu5vZgJRn7H
         h/BVx804/ygqk1Rc3PRYGNBxCtLltENmaWqjiwQj//xWNmv5OtK8uMYKh+xar1uhWXUl
         BVuA==
X-Gm-Message-State: AAQBX9f6yZkS/7C11beLnjt75X/jffSv+6LDRDD0IJJ+mUj/CsGp77Z9
        BKZS46rSiAkGbyBH2eb1eZ0LQA==
X-Google-Smtp-Source: AKy350Zvo6yw2WjYSzxSEIMYhxNr/CD8L31/jLo39p3tNpKrx9eEeS92OCadetvs5W0qJXfUEWkPjg==
X-Received: by 2002:a05:6214:5298:b0:574:8ef8:89d1 with SMTP id kj24-20020a056214529800b005748ef889d1mr37146151qvb.5.1680190726150;
        Thu, 30 Mar 2023 08:38:46 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id f29-20020ac86edd000000b003e390b48958sm2034475qtv.55.2023.03.30.08.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:38:45 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:38:45 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2 01/14] drbd: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Message-ID: <20230330153845.GG2114899@google.com>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
 <CAEXW_YQehT7Zj0G4nBj-0b+Ndq_FTxFzxQ-WYnBGJ=87wPBHYw@mail.gmail.com>
 <e5b78f91-122a-0b0d-8d3f-922d462ba44d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5b78f91-122a-0b0d-8d3f-922d462ba44d@kernel.dk>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 27, 2023 at 01:26:39PM -0600, Jens Axboe wrote:
> On 3/26/23 6:27 AM, Joel Fernandes wrote:
> > On Wed, Mar 15, 2023 at 2:19 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> >>
> >> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> >>
> >> The kvfree_rcu() macro's single-argument form is deprecated.  Therefore
> >> switch to the new kvfree_rcu_mightsleep() variant. The goal is to
> >> avoid accidental use of the single-argument forms, which can introduce
> >> functionality bugs in atomic contexts and latency bugs in non-atomic
> >> contexts.
> >>
> >> Cc: Jens Axboe <axboe@kernel.dk>
> >> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> >> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
> > 
> > Jens/Others, any chance for an Ack here?
> 
> Begrudgingly-acked-by: Jens Axboe <axboe@kernel.dk>

I applied the Ack verbatim, thank you!

 - Joel


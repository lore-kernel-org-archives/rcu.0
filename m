Return-Path: <SRS0=r7Mw=CX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A561BC433E2
	for <rcu@archiver.kernel.org>; Mon, 14 Sep 2020 20:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D13320E65
	for <rcu@archiver.kernel.org>; Mon, 14 Sep 2020 20:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NsPJNjED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgINU0N (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgINUVY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 14 Sep 2020 16:21:24 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093A0C061353
        for <rcu@vger.kernel.org>; Mon, 14 Sep 2020 13:21:23 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id t20so1171494qtr.8
        for <rcu@vger.kernel.org>; Mon, 14 Sep 2020 13:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PibvaXKoznf5f0ofpz35J88QRgIi2RKLSkzT49/BMFo=;
        b=NsPJNjED9anboAsRVmaMfkp4+nZaSyWJ+pH6SjTdYa5ss7vIf+9uzg3ONT7cfz6sds
         TICFfkUMJpkTMW6KUP6/JqSzBsP0SiOE2pFGgIHQ7ihRq9ZyzAkGOUm2JqAa/+jZbr5h
         BcB3cxoPlx/vR/jNC21lvQAyKdd6LxPX/vSqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PibvaXKoznf5f0ofpz35J88QRgIi2RKLSkzT49/BMFo=;
        b=cSYPUaACBZ7IJmiVpYaiugHMmGbE7TAnwFaZlqdZmVQXlgY9gKB3r58lPQdk1etu8J
         EYvd5tFKsv0OSkjgX+rBTbL5EscYeuoIQNsuKXX7vWv/+QuEiBVPkEAltAiVmqxmbTKj
         S3pthyDucG4sL6HrjirVQZPytJZKDj07mRiWKE9apGNPBYo2j3zlaaiqk70XI8kiUhXj
         CIph2YYPyGrAU+W7uXwQ4P0HT5an9W+EnVodV5QzwI62kNPr/qldluSRw0IUsp6j7u1o
         rYce7rLp5WYGEpcZ6XGdkiy/KQjmV7nGua9QIFFvq4OUqe/8wudvtyXgBmtJ3XgkRs56
         hvaw==
X-Gm-Message-State: AOAM5319IovMCqJIG1IBpUzRJYwybFMU7+8n/q/VBrPaR5O+CSvrza2i
        /rxthJboHPjyWt05feC1VL0a/g==
X-Google-Smtp-Source: ABdhPJxVMkiX3m94aVgDXiGhsRMu0roOO/EAg17fNyawnWQkijB0WjKEVXEoiSXN9GYF6ralSMf9ew==
X-Received: by 2002:ac8:474a:: with SMTP id k10mr15348990qtp.115.1600114883163;
        Mon, 14 Sep 2020 13:21:23 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id v90sm15138751qtd.66.2020.09.14.13.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:21:22 -0700 (PDT)
Date:   Mon, 14 Sep 2020 16:21:22 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     nikolay@cumulusnetworks.com, davem@davemloft.net,
        netdev@vger.kernel.org, paulmck@kernel.org, josh@joshtriplett.org,
        peterz@infradead.org, christian.brauner@ubuntu.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au, roopa@nvidia.com
Subject: Re: [PATCH net-next] rcu: prevent RCU_LOCKDEP_WARN() from swallowing
 the condition
Message-ID: <20200914202122.GC2579423@google.com>
References: <20200908090049.7e528e7f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200908173624.160024-1-kuba@kernel.org>
 <5ABC15D5-3709-4CA4-A747-6A7812BB12DD@cumulusnetworks.com>
 <20200908172751.4da35d60@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908172751.4da35d60@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 08, 2020 at 05:27:51PM -0700, Jakub Kicinski wrote:
> On Tue, 08 Sep 2020 21:15:56 +0300 nikolay@cumulusnetworks.com wrote:
> > Ah, you want to solve it for all. :) 
> > Looks and sounds good to me, 
> > Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> Actually, I give up, lockdep_is_held() is not defined without
> CONFIG_LOCKDEP, let's just go with your patch..

Care to send a patch just for the RCU macro then? Not sure what Dave is
applying but if the net-next tree is not taking the RCU macro change, then
send another one with my tag:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks!

 - Joel


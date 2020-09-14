Return-Path: <SRS0=r7Mw=CX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D95C433E2
	for <rcu@archiver.kernel.org>; Mon, 14 Sep 2020 19:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C053C2193E
	for <rcu@archiver.kernel.org>; Mon, 14 Sep 2020 19:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ycFv4Bvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgINTmL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 14 Sep 2020 15:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgINTmK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 14 Sep 2020 15:42:10 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781A6C06174A
        for <rcu@vger.kernel.org>; Mon, 14 Sep 2020 12:42:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id r8so1000579qtp.13
        for <rcu@vger.kernel.org>; Mon, 14 Sep 2020 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bV57W/EOWURMleEzGNWcf5dyMu6bebp1Bh//1ts4NWM=;
        b=ycFv4BvlBYEkf4hQQlNujtn6QNIE5wc63ULQhK/2rdi3VgfJU/q02dwetcIo2piGTH
         rh/aYu1xqMcmOyvTuxx+ofXk9NejE5iYqXBRPCZv1yZGAewKXIe8FTxOdG7k/J6M1sxE
         7G4lDmw6QFHiyI5TTTVyysspAIwYVgx7l5jrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bV57W/EOWURMleEzGNWcf5dyMu6bebp1Bh//1ts4NWM=;
        b=T9hDTSZPddcfyDAXE92LvXTrHsV74MXdOftuT0H8+nyJTpr+FwgUCuKv6/H7FjYHu6
         zAMaZfum7hMKx1tjHNbz/c9nYSkScOmnK0e4Z+0ENYmA1ItzkDsvPxGH4Ih+07hZZilG
         YTsTFsDcpdB8J0AOlb8sIpiz20sBjZgMwPMMKQbRnsy8ytQjQgR5W+FDaO/0//oKRX98
         DLuJ2kDFALrIAT3FPGknVG73rCv4qLDva4IKXyTapYodi2hpsMjMi04Ouyk+XiPoUBnC
         c02txzotAb5Ci8Lg7vhnTZ1kQw4gzqeGRYBc/vM8Uz6q8syskkyhh7ZNsvb/qQLfA7Zi
         h63w==
X-Gm-Message-State: AOAM5332rpOs+bfqeWbCBMSVrrFh/juo6Rq8Nc+K+xFgFj4G4FUA1TOW
        gX9FlZFXtYYeoKEL/Y2sBRHXSA==
X-Google-Smtp-Source: ABdhPJxbhI7ln6hIC6I1YHJZhDkQq9/+B5olyYYdwWGSbKtZqDX4OuVuBiAuMqDC7ZA4iMYVUGfbAQ==
X-Received: by 2002:aed:38c9:: with SMTP id k67mr2489411qte.6.1600112529305;
        Mon, 14 Sep 2020 12:42:09 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id k68sm13520108qkc.33.2020.09.14.12.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 12:42:08 -0700 (PDT)
Date:   Mon, 14 Sep 2020 15:42:08 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RCU: Question on force_qs_rnp
Message-ID: <20200914194208.GA2579423@google.com>
References: <BYAPR11MB2632C4C06386B39BB5488428FF230@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB2632C4C06386B39BB5488428FF230@BYAPR11MB2632.namprd11.prod.outlook.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 14, 2020 at 07:55:18AM +0000, Zhang, Qiang wrote:
> Hello Paul
> 
> I have some questions for you .
> in force_qs_rnp func ,  if  "f(rdp)" func return true we will call rcu_report_qs_rnp func
> report a quiescent state for this rnp node, and clear grpmask form rnp->qsmask.
> after that ,  can we make a check for this rnp->qsmask,  if  rnp->qsmask == 0, 
> we will check blocked readers in this rnp node,  instead of jumping directly to the next node .

Could you clarify what good is this going to do? What problem are you trying to
address?

You could have a task that is blocked in an RCU leaf node, but the
force_qs_rnp() decided to call rcu_report_qs_rnp(). This is perfectly Ok. The
CPU could be dyntick-idle and a quiescent state is reported. However, the GP
must not end and the rcu leaf node should still be present in its parent
intermediate nodes ->qsmask. In this case, the ->qsmask == 0 does not have
any relevance.

Or am I missing the point of the question?

thanks,

 - Joel


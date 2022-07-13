Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A45C43334
	for <rcu@archiver.kernel.org>; Wed, 13 Jul 2022 21:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiGMVjg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 13 Jul 2022 17:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiGMVjc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 13 Jul 2022 17:39:32 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C911B7DC
        for <rcu@vger.kernel.org>; Wed, 13 Jul 2022 14:39:32 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id i21so3790qtw.12
        for <rcu@vger.kernel.org>; Wed, 13 Jul 2022 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nuxfK0q2wf4Rn7CeoW2/Kq/kuz+vEBF33gCfxjJbFD4=;
        b=kQbrFtHvDKJgH7vuf7sh3I7tgMJXNiSwgrZzmmWaYLTljOhU7O8IlGwRAH1NZLOP5m
         eTXsGIGkZl4Uo0ATajfHHUytsD+Dm3tOR2xyG8lfZ/+0JOm9qm2QOTs//kHlLZ+QSB8M
         5rfFeK/fcVRHCaIQ4cTgxASOFx7R+2QzqQST8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nuxfK0q2wf4Rn7CeoW2/Kq/kuz+vEBF33gCfxjJbFD4=;
        b=sEC0j0Z73lKIcrKxEPmEmkuz2uGpcOhHFYUmbv2K9URvNDsYxjplyOQ7pQs+xI01BG
         W0H+syjQvGKJ3rNj+mlrk14ixB3GR3W+NxkDpBh3jZ4SdUTqHEIL8lVkg+tfLIspfdJp
         A1FUmeIrU/2inYJyJepN81PHE1lUUL9oEARWFtpTZUllmu+TV0NUueUTVp/xWqnjeLZM
         85PBsJZ5xWBxmwwgSrorz6Kfcx46FZDnQd0wnBaxOj1bjJqNuVU32Yr96oVfGIaxrNKg
         PIJz+0VSUn5O08BJt5UxpXLxqYL8ttfFe0Xw1968+J5ycx+bm8Q9XELaOFBVBaU/WZGf
         ZMMw==
X-Gm-Message-State: AJIora+OY1xpjylRpCl3p77Yd6pHn9BKBTcXIhS6Rdre+p3yFL6aAS9u
        yi2abk3Uca+YZwrML0xIsjNMPPjeErnQCQ==
X-Google-Smtp-Source: AGRyM1vPtKnS+ya20dlvO6jDoeU4guIzfxTJmt9q4vuJATJuUb66VfV2gi2rgbmyZn5JD3fSxbZbTw==
X-Received: by 2002:ac8:5c15:0:b0:31b:f0a5:fab0 with SMTP id i21-20020ac85c15000000b0031bf0a5fab0mr5241459qti.77.1657748371142;
        Wed, 13 Jul 2022 14:39:31 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id j15-20020a05620a288f00b006a3325fd985sm12972034qkp.13.2022.07.13.14.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:39:30 -0700 (PDT)
Date:   Wed, 13 Jul 2022 21:39:30 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH 1/5] rcu: Introduce call_rcu_lazy() API implementation
Message-ID: <Ys87ks05PD17dFz1@google.com>
References: <20220713213237.1596225-1-joel@joelfernandes.org>
 <20220713213237.1596225-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713213237.1596225-2-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 13, 2022 at 09:32:33PM +0000, Joel Fernandes (Google) wrote:

> + * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
> + * resulting RCU callback function "func()", then both CPU A and CPU B are
> + * guaranteed to execute a full memory barrier during the time interval
> + * between the call to call_rcu() and the invocation of "func()" -- even
> + * if CPU A and CPU B are the same CPU (but again only if the system has
> + * more than one CPU).
> + *
> + * Implementation of these memory-ordering guarantees is described here:
> + * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
> + */
> +void call_rcu(struct rcu_head *head, rcu_callback_t func)
> +{
> +	return __call_rcu_common(head, func, force_call_rcu_to_lazy);
> +
> +}

I will kill that extra new line. LOL something always has to go wrong no
matter how many hours you spend making sure eveyrthing is good :) Luckily
cosmetic here.

thanks,

 - Joel


Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F5EC433F5
	for <rcu@archiver.kernel.org>; Thu, 27 Jan 2022 18:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiA0SdH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 27 Jan 2022 13:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbiA0SdG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 27 Jan 2022 13:33:06 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872EDC061714
        for <rcu@vger.kernel.org>; Thu, 27 Jan 2022 10:33:06 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E380137C;
        Thu, 27 Jan 2022 18:33:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E380137C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1643308385; bh=wU1Vu5D+dAN0l9EXg3C/zuxBucv9lbkAhwlKPeVKzzg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lgUAy+WPRqbFyCgsy+OnBeV3VrLdA8XJH2j60ROycI9bEdr0vBuYNhdVuWTHtgur3
         lrdq91v3/1Ib5gG3L9DZvaQdyF4uga5ulaIOrqJ0zpWKTKO8p7qOKJ+6t6f2CwcQx2
         +fnEWj9ZkShNX9ISSZPPaIqJsiMFo/V0B0OOyr358HnZgbCN01Jf7fPStLkj6zqwSv
         ZHh5Dt2Iyl3jS/SNzTvo1F+eYoOiRrOIrJeLP0hVPYfiO5v339e717X7cxvqZxgjV+
         2cLuINC4eBQPt4j93chdTfQ8ivjHxeKFdEF9TuFPfA0duojCCxeFqD8r0WMWn2dh3G
         joH0JSE/GoMkQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>, tglx@linutronix.de,
        mark.rutland@arm.com, paulmck@kernel.org
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
        peterz@infradead.org, mtosatti@redhat.com, frederic@kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: Re: [PATCH v4 1/2] Documentation: Fill the gaps about entry/noinstr
 constraints
In-Reply-To: <20220110105044.94423-1-nsaenzju@redhat.com>
References: <20220110105044.94423-1-nsaenzju@redhat.com>
Date:   Thu, 27 Jan 2022 11:33:36 -0700
Message-ID: <877dalrptr.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Nicolas Saenz Julienne <nsaenzju@redhat.com> writes:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> The entry/exit handling for exceptions, interrupts, syscalls and KVM is
> not really documented except for some comments.
>
> Fill the gaps.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de
> Co-developed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>
Both patches applied, thanks.

jon

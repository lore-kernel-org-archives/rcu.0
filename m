Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55660C43616
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 06:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F21600CC
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 06:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhEUGjE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 21 May 2021 02:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhEUGhn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 21 May 2021 02:37:43 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A146EC061574
        for <rcu@vger.kernel.org>; Thu, 20 May 2021 23:36:06 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v14so10751959pgi.6
        for <rcu@vger.kernel.org>; Thu, 20 May 2021 23:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UVoSQt4bLtT7Ix7kL6FeuZytha01b8oiry7YrK+fTN8=;
        b=O0Tsv2NgoSNJGN/n8RA+0/CnX4A0Q+hDHD0wxiW/VI31W/rDazcCKXlaprXTzDBn5i
         d/gn078PqPAxCSkmROFzkR7FIZBHhYQC0cuSgOcFmNkM/SmFwZS3d5MAMomafuSOLkmI
         /r8LttGy68w6xwwN+AH6eOZ/f04tT8Wzn8X08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UVoSQt4bLtT7Ix7kL6FeuZytha01b8oiry7YrK+fTN8=;
        b=DyQ/oTk/IMLdhpMDY/Ma04ZWLwkI4LCguvcBXILfY99OFDFEAfIeAKueyxA8C6PQ1x
         7D+zTJUpZja6hop3p4A9knIYAbx0W1aNppmzxJZkrVexZkH+gdaztOpoXxvJ5VpK1kkV
         CyXJNbrDtHHlCe5Vs9kGlIUmeWP4Bzg23R8D4kFD/WU2lyCaccC+X+BzyA85IUzBcteg
         ii8inRyF9slAcRAJ2uT2CE/+Is7VXI1qaMQ8+Oeg6P5n5oM2Wp4cWhoqM4dwHA+2bXqO
         tcx2pmgjZhGYyIWIk3SvwpyEBKL97W9gA/dEDK27n0+qIUNljsoOKGmpOR/nI8gSxvBk
         g0iA==
X-Gm-Message-State: AOAM532ampw3NOARTO6iB5wFc2uLksf4xiNw1juUDl3GRWKb1+C8eqsA
        yhEk5OhdB7boscB7mc/mw4td4w==
X-Google-Smtp-Source: ABdhPJwe5ro/3a3QCBjQ+lr2f3q8xPap4d4GhZdjf9urA1CJtx3xfDAv/fTqpX47WGZFPyZd7FzvZA==
X-Received: by 2002:a63:5a43:: with SMTP id k3mr8391295pgm.308.1621578966210;
        Thu, 20 May 2021 23:36:06 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:245d:3890:fa95:996e])
        by smtp.gmail.com with ESMTPSA id d12sm3456808pfv.190.2021.05.20.23.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 23:36:05 -0700 (PDT)
Date:   Fri, 21 May 2021 15:36:01 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: consider time a VM was suspended
Message-ID: <YKdU0U0aHKm2x3Y7@google.com>
References: <20210516102716.689596-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516102716.689596-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On (21/05/16 19:27), Sergey Senozhatsky wrote:
>  kernel/rcu/tree_stall.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 59b95cc5cbdf..cb233c79f0bc 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -7,6 +7,8 @@
>   * Author: Paul E. McKenney <paulmck@linux.ibm.com>
>   */
>  
> +#include <asm/kvm_para.h>
> +

D'oh, why did I do this...

Paul, I've a trivial fixup. How do you want to handle it?

---

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index cd815b19740a..b9b52f91e5b8 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -7,7 +7,7 @@
  * Author: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
-#include <asm/kvm_para.h>
+#include <linux/kvm_para.h>
 
 //////////////////////////////////////////////////////////////////////////////
 //

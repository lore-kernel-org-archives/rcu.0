Return-Path: <SRS0=Iwfc=46=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE350C10DCE
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 13:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C193820724
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 13:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgJaXz4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCMNol (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:44:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37019 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgCMNol (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Mar 2020 09:44:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so10587559ljd.4
        for <rcu@vger.kernel.org>; Fri, 13 Mar 2020 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GVguspHHKCamFp8T0zH26ZIZjW2dU07wwv0gmwnMTA0=;
        b=KgJaXz4KK7vKp+SHeXBUQvvpvR7+iX9W1GNawB9YYP2mEwoa5WVsZKzKBEnJdkbZNd
         Cul03E6iak99ZkYh53mGvTz1ohODGPB5vHNHwJQEH/mAot4n/YH35+2PNIflq3PHCmZ/
         Mw3goQPcUQvo5x7TE1DlaVT9ZNkVP8CTlearoi2zXOrdzj1bZ+QIT6gKTcVCPEyPU+t7
         O/wXizY47PMb/uMbZ5n1iOXZ09h8pK0MAeG/cQECQvNtMEkSFlDFWKUKabsB1MW5Rq7D
         C594U0KT89tQwaoYxogeOdsAdf62kA/rgyHUF3pqJikJBjBnoL+98wwS8ymGLv3DEQFc
         qoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GVguspHHKCamFp8T0zH26ZIZjW2dU07wwv0gmwnMTA0=;
        b=dR7gP5lCJhe7d7dDvEavhodEzcOUCgB6eL9KbmXI1jsaA2ph9M/h7Wi2+ZFUvtGE0m
         O0ZoSlsJx7G9lm+zFmYD5Su+EtgJvRGzkcPAtpXEvS3+nX84S/+0xKeyOPoNB4zy8kc5
         yxuO6X7gFXUD3z7TxGSe6YAGh4dJD8YqWnjFfb1HocpmuHCC+wQeuaq56smqSGFDYCAY
         Mnjo/0c39pKNlMo1rzlnH5xRyYikTF5CF672jSKYp/UG/FGeilazSjmIzD5dixBIyzMe
         VimOiH/3Msm2H/IhgdAsxtNOHyx2fyOud2WjaG2f7kFmtSnqsm+L31vRdyvO3YCn6SRM
         ap8w==
X-Gm-Message-State: ANhLgQ0LX0LLE+DMurckV8ugHibM0+09BOVv0NenKa9WJ/oq9ySpaEVw
        ZU2Kv5NQDvpc6Uyw95lC/CI=
X-Google-Smtp-Source: ADFU+vv+7jgwYD1Ut4jeli1eclZ08H/VM6srnJ/jrSqgjoPDpzzC1UXTbtVR2J8ThttabWFK3Hk1/A==
X-Received: by 2002:a05:651c:21b:: with SMTP id y27mr8396697ljn.164.1584107077199;
        Fri, 13 Mar 2020 06:44:37 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id p19sm1860795lfh.72.2020.03.13.06.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 06:44:36 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 13 Mar 2020 14:44:34 +0100
To:     George Spelvin <lkml@SDF.ORG>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Subject: Re: Is there a reason we don't have kvfree_rcu()?
Message-ID: <20200313134434.GB28457@pc636>
References: <20200312162730.GB11889@SDF.ORG>
 <20200312181138.GI3199@paulmck-ThinkPad-P72>
 <20200312191009.GA27429@pc636>
 <20200313050659.GA22938@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313050659.GA22938@SDF.ORG>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 13, 2020 at 05:06:59AM +0000, George Spelvin wrote:
> I'd just like to mention that the is_vmalloc_addr() test depends only on 
> the virtual address, so can be done when the memory is queued, before the 
> grace period.  That is, you could have kfree_rcu(), vfree_rcu(), and a 
> kvfree_rcu() function which decides between them.
> 
> One advantage of that would be that you could put the vfree() sanity
> checks into vfree_rcu(), so errors would have a useful backtrace,
> and just do the __vunmap when the grace period expires.
> 
> Or you could build a mixed queue and do the is_vmalloc_addr() test at
> the end of the grace period.  That was my original idea, because it
> avoids the need for a separate queue.  (In the _rcu_bulk_data structure,
> you can do a quicksort-style partitioning on is_vmalloc_addr(), so
> the kfree_bulk() pointers are all contiguous.)
> 
> Just an implementation option.
Thanks for your input. Mixed queue would require sorting, one node can
contain up to ~509 elements if PAGE_SIZE is 4096, so i am not sure how
it would impact performance under heavy load. But anyway, thanks again.

--
Vlad Rezki

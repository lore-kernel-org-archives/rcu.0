Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B245C4321E
	for <rcu@archiver.kernel.org>; Tue, 22 Nov 2022 21:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbiKVVbE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Nov 2022 16:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbiKVVbC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Nov 2022 16:31:02 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E2DB9610;
        Tue, 22 Nov 2022 13:31:01 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id io19so14886617plb.8;
        Tue, 22 Nov 2022 13:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgAzLb21LUXWU3y9hF9rBv/DHaAVEQZ/YKwR9d55bTI=;
        b=YVQdzVIZbibPhLOEFlF57clDLA+X15XkRrsfUglOAE9R+Cpix/tplVgJcMXWAextq6
         Cj7BLFYJ4Mdkcm98HnTNCj1y9w/cNF9O+FImxwZlMzkc1vVPv/+EWHZspB9Ubp7IxbKx
         16eDF/6XUv9XZ9jafVapPTmjJeaB8wCeVqT4FTHngDXVpqjsuJKfOoNV9q3cbq62AkPA
         jhVdZ0Z4Z/XJO4VPfoaRPvJmFZaQFWyQTH+F02dCexifBwMbKea+qvkjhWkDwjIKVzqe
         tX3Q+XY5s91LEVenN+2MxsnNA36q/185ANW898Na7J2Cbto+889mXoi/C+sW1SoDfn5j
         90Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgAzLb21LUXWU3y9hF9rBv/DHaAVEQZ/YKwR9d55bTI=;
        b=Ek6aM1Aly6tIq+IDkvyOS/wdoIO7kQSGMzludcKamQBpsAUYm89/JUfklVPbGCOmhi
         tRALQdJ5E012YfoPbKezrTtIN4F2BEvMVIYVCJA9UxPKSMtSvJeKYRrxCudRqkh0LTep
         7UoYqIpIBm8thF6bPrM2s4FJROdvZWi1ZhzW72CZVMiRUPW1F0tKwbgg/kLEt1qOq5bJ
         oFeA53NmnygTatYuEi4AuFr0f2WG5Fa676TLrIH5Pov+VCTx1r/mSc09Oqic/UhZzua/
         Wl31malw9y7Y+Jsci4TadJLjWBMUjPxTZ6aPYMIp6E7sKTQetURgzIfEKz4QyGNHSpVH
         JZmQ==
X-Gm-Message-State: ANoB5plulAHLfSdwUFhg7DGczVhNBih/eG16GRc72/eS//ae+3zmYvOB
        PxodhVxB7v4fLL92rYC3lEM=
X-Google-Smtp-Source: AA0mqf5HxKVR8LTCNXRXWXwrEqv6V5Z/JxABGLA60tu8cexYrguplGO1C8PjL9HR1ebhh7j3Ct32TQ==
X-Received: by 2002:a17:902:ef44:b0:185:40ca:68b8 with SMTP id e4-20020a170902ef4400b0018540ca68b8mr7210411plx.16.1669152660911;
        Tue, 22 Nov 2022 13:31:00 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:bb3])
        by smtp.gmail.com with ESMTPSA id q16-20020a17090311d000b00182a9c27acfsm12587293plh.227.2022.11.22.13.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 13:31:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Nov 2022 11:30:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 rcu 13/16] workqueue: Make queue_rcu_work() use
 call_rcu_flush()
Message-ID: <Y30/k7uPX99Qgni4@slm.duckdns.org>
References: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
 <20221122010421.3799681-13-paulmck@kernel.org>
 <Y3whScgTs0FgrVtY@slm.duckdns.org>
 <20221122012357.GV4001@paulmck-ThinkPad-P17-Gen-1>
 <Y3wn9AK1XxEZIIFw@slm.duckdns.org>
 <20221122015202.GC4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122015202.GC4001@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 21, 2022 at 05:52:02PM -0800, Paul E. McKenney wrote:
> Maybe we should have used call_rcu_hurry()?

That sounds good to me.

Thanks.

-- 
tejun

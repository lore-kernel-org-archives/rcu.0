Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D798C5479D
	for <rcu@archiver.kernel.org>; Mon,  9 Jan 2023 17:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbjAIRna (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 9 Jan 2023 12:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjAIRn2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 9 Jan 2023 12:43:28 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5611A229
        for <rcu@vger.kernel.org>; Mon,  9 Jan 2023 09:43:27 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 7so6405083pga.1
        for <rcu@vger.kernel.org>; Mon, 09 Jan 2023 09:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GSSXv+I+w/8fq5Yx5Ez6ORBTwPIwCfMMjmGhcpp+UqU=;
        b=g0eGXd1q88kKO1UBdVGzjP/95p/jpiFOz1tlu9gArFeF2qE16G4bVRKZnTw+XZWtP+
         EXrJCYtuU4eMsLsoIGwLHGE/k07Dndjexhtc4+89wiIh6t0htZq88FgfPeF2HiM+62gW
         6bVYPLutu6hFNdoSRn3rQ3obSPWJsZ/DaHbp0ph0JiEXjk2KMis4Qd8AW9xA1OlPRfcO
         IRE2Tydovrr2fE+hnvN0agTBvFC49yxzQWirTToKPy0kam/RY/O5O+6uTm/r2z8YrQ3h
         YOdKyhwgMJMT55xd9yRJf6srnW5aApxQjTtPOI1niagvZTpis4FDOtgy/qD+Nl8IXzWT
         vPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSSXv+I+w/8fq5Yx5Ez6ORBTwPIwCfMMjmGhcpp+UqU=;
        b=t/xP8INvZvxPJ/soOkqe17Q5q7Z6ouLMAiiwHYpEsU8vdh6OguTGPoSTJEdM5swtEQ
         neCYdtaly1YHLvXj/p9Hs0CSAsPQF3Itf8KlzFP99ySxSWO8FgX+b0PD3mKQ1QKgtw1y
         MUIqsU/apsCQeuKxiHTX6MwYbP8/TeoJtTKK2WgX5tIsBdk4gJ7yK+CNozBUn8KCh9ia
         sCU/XQLwXbqaUD51zpFBgffafcPhxDIITY1o9QOIrqkb76GlcY3bSRtq216flF9F86u4
         ZkDvmG/ceH3l26+VXMTh3bjzdi81LQaXXHD5+W0pCNpdm9n0Dcwone2yzH9LuIN+YbIT
         yihg==
X-Gm-Message-State: AFqh2krnLVFDWzoz6Y2R1DoVMFnm6StxLzH7NSjK92GGhDMa/WlOllHS
        X2C+kcWjfso0Jdy1klsC5mTgnw==
X-Google-Smtp-Source: AMrXdXuahdX5fT5IrjPkz4RnJUA4Kk4OaigXHUxhSIcCKVvee6MrvxGtSvPNdBbAdchzeYDmGAb45w==
X-Received: by 2002:aa7:9249:0:b0:576:9252:d06 with SMTP id 9-20020aa79249000000b0057692520d06mr740111pfp.0.1673286207259;
        Mon, 09 Jan 2023 09:43:27 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id k197-20020a6284ce000000b00574b86040a4sm6350861pfd.3.2023.01.09.09.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:43:26 -0800 (PST)
Date:   Mon, 9 Jan 2023 17:43:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH rcu 01/27] arch/x86: Remove "select SRCU"
Message-ID: <Y7xSO2dW1sy21RVz@google.com>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105003813.1770367-1-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 04, 2023, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: <x86@kernel.org>
> Cc: <kvm@vger.kernel.org>
> ---

...

> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index fbeaa9ddef598..9306d99585188 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -46,7 +46,6 @@ config KVM
>  	select KVM_XFER_TO_GUEST_WORK
>  	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
>  	select KVM_VFIO
> -	select SRCU

Would it be too much trouble to bundle all of the KVM changes into a single patch?
The SRCU requirement is a generic KVM requirement that's handled in the arch Kconfigs
purely because of KVM's somewhat roundabout Kconfig setup.

>  	select INTERVAL_TREE
>  	select HAVE_KVM_PM_NOTIFIER if PM
>  	help
> -- 
> 2.31.1.189.g2e36527f23
> 

Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA3DC761A6
	for <rcu@archiver.kernel.org>; Thu, 30 Mar 2023 15:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjC3Pf2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Mar 2023 11:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjC3Pf1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Mar 2023 11:35:27 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6589EF1
        for <rcu@vger.kernel.org>; Thu, 30 Mar 2023 08:34:59 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id a5so18821443qto.6
        for <rcu@vger.kernel.org>; Thu, 30 Mar 2023 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1680190497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dWYy+yIYC80mtaAFCxVL4Mtfo9wOiHHe01YJbPPjuVk=;
        b=K8M+XwfBVftcHC6JqKRdpCOnQJTjtpnm/7FiSC0XktaLYeJ71TUqmmsNzTNGzZr3+a
         xy4OgFQuAJS21qxniFa6a5cnfA0q/iHF2Gj4vahE+HZrE7cbPeos6YS1CEwQkE79UlcT
         27Kqx/71pJ0lkiNKSwIgZGMT3CzXG5ZzFq1DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680190497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWYy+yIYC80mtaAFCxVL4Mtfo9wOiHHe01YJbPPjuVk=;
        b=Lg+ouCVo/hEhyAl9B/bBDsfrW5FpyZIErI7oz1T0ls1oWvEMAbMkQi1ADh7zyGRVC5
         ZUJuCHQmHoKe1krhEOFL6mWB0qlovacmymhhjKhEXk3f7/D58fcvoa2JeDm5uSxbZIEN
         yaKBQpgECv5D130it70jY9PPyCRK+lPSqDmvI3V+VT6SsVE9pSV5SEtqSfAX9NdHsirG
         knE+ot7j8Wml+kQV+15GaVx102NEz51zeyuzc1qJKe6FFTUZQoB06v7tdsdl6BympMKG
         K69vgtmOTxa/K0Ep4iIieb0u9XUqtBHIkr4yVfaoeqQtn7j52hECEMm9OPeJ8l9Xotxl
         46+w==
X-Gm-Message-State: AO0yUKVtneq+m35mmbdIgohiuisvOUAmLvCxKGK3Qe1Vu2haUIcvGM85
        a134sHnmWZqpggQ3UE/Q3Q8gWcXGV2tmvxA3aHM=
X-Google-Smtp-Source: AKy350b7u1wAHRxGdLMZc7EGNszBgJsKH/HSE7DAw/WT2YDHT7lA0XNO4gPC2BKoVmbr/Nf553JALA==
X-Received: by 2002:ac8:5e13:0:b0:3e3:7dc9:b85a with SMTP id h19-20020ac85e13000000b003e37dc9b85amr40467532qtx.59.1680190496727;
        Thu, 30 Mar 2023 08:34:56 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id g7-20020a37b607000000b007486cc8a3f8sm3697312qkf.23.2023.03.30.08.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:34:56 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:34:55 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH rcu v3 2/4] kvm: Remove "select SRCU"
Message-ID: <20230330153455.GF2114899@google.com>
References: <8ae81b0e-2e03-4f83-aa3d-c7a0b96c8045@paulmck-laptop>
 <20230324205249.3700408-2-paulmck@kernel.org>
 <ZCJzYktdNRZmQjhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCJzYktdNRZmQjhl@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 27, 2023 at 09:56:02PM -0700, Sean Christopherson wrote:
> On Fri, Mar 24, 2023, Paul E. McKenney wrote:
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements from the various KVM Kconfig files.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Huacai Chen <chenhuacai@kernel.org>
> > Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: <kvm@vger.kernel.org>
> > Acked-by: Marc Zyngier <maz@kernel.org> (arm64)
> > Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> > Acked-by: Anup Patel <anup@brainfault.org> (riscv)
> > Acked-by: Heiko Carstens <hca@linux.ibm.com> (s390)
> > Reviewed-by: John Ogness <john.ogness@linutronix.de>
> > ---
> 
> As amusing at it would be to see KVM as the lone holdout,
> 
> Acked-by: Sean Christopherson <seanjc@google.com> (x86)

Applied the Ack, thank you!

thanks,

 - Joel


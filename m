Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91434C38147
	for <rcu@archiver.kernel.org>; Wed, 18 Jan 2023 01:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjARB1o (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 Jan 2023 20:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjARB1m (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 Jan 2023 20:27:42 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4EB3D0A7
        for <rcu@vger.kernel.org>; Tue, 17 Jan 2023 17:27:41 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q64so34247463pjq.4
        for <rcu@vger.kernel.org>; Tue, 17 Jan 2023 17:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1nIKn+mjTOyaw7oYAqM6VZKaiRDNDz61Nt/7Rj2z1BI=;
        b=qGZzcOXLu0FbgGjL5piUb5jTQduasxBpKM/jyb4tJs9xKtN12lUPc9yFHF/DKTeQ/A
         CwIFjwBIeoZvTD1hQz4EIJ8VtLAHBgUe1tfkiHHE46uDNYe1ZcRtE5hl3mso3aQ5AtKU
         BmhJxdigjnXUe4G0uXWWGjtfjFGiWn+20yWT0dmOOFkM7V2Wq/ZCCYGI97KVKvmtOC3l
         cwUaiclnkMb2GQrpiFsYD/o961X76p3WqQfXoyfB99IUaDbTV3SLcqRXDW4UVP8qK/H7
         m6CfKg7m6i56iGYFNNPyq5KZ18/ObmauPWszXqpHED3YTw7AXfDKrFjJm2uigX9qccaR
         Tzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nIKn+mjTOyaw7oYAqM6VZKaiRDNDz61Nt/7Rj2z1BI=;
        b=ZurIGv+VrE7qKygvAI55gHch5Ws6wcsOqctC5QYLnMTa8D/n8CAHjRldg8xOPafPz8
         culLqoUBDdU48aC9eQn1ajSVRMWAEquKXlYB4ZorJWffd0NjBP7yFJQh2kU0zQN4jInH
         LLUoZTQ2q9IzsUfgXY1TmegKoaY1CGngTWzG/QJwCqeWe5co+VyYkSAUOBj2YDeRzuU0
         IO2RqxelLjmdD5gZ8fZ3zbotKzMyAUh444YauWaAA52AaHlnkk+wKj1F245YHiOp0zcb
         6qK/AEld0MujU61xO4nj2Mn1NQbC+X92jFvesZr1DSC2Y/dQ2Zumy8WzI5rDMolZWPGQ
         N86A==
X-Gm-Message-State: AFqh2kpRv3U9BuLQvby1CzvBPBtBFZajOlyiLfs3CzkGX328FE1J1xL4
        T5qad5HdgjDW+YuqCd04lrC5iw==
X-Google-Smtp-Source: AMrXdXtjHnm119JHGEWlVS/W/4yVt15DKqhdxOIzLp58H8TMc13vhHeKOtp5RxHarHERytO5ZQBcIA==
X-Received: by 2002:a17:902:d409:b0:189:6624:58c0 with SMTP id b9-20020a170902d40900b00189662458c0mr2356707ple.3.1674005260722;
        Tue, 17 Jan 2023 17:27:40 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id jd9-20020a170903260900b00186727e5f5csm21784578plb.248.2023.01.17.17.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 17:27:40 -0800 (PST)
Date:   Wed, 18 Jan 2023 01:27:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH rcu v2 17/20] kvm: Remove "select SRCU"
Message-ID: <Y8dLCJKXn5fL/2Iq@google.com>
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
 <20230113001132.3375334-17-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113001132.3375334-17-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 12, 2023, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements from the various KVM Kconfig files.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <kvm@vger.kernel.org>
> Acked-by: Marc Zyngier <maz@kernel.org> (arm64)
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Acked-by: Anup Patel <anup@brainfault.org> (riscv)
> Acked-by: Heiko Carstens <hca@linux.ibm.com> (s390)
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>


Ugh, my apologies Paul.  I didn't realize 0cd7e350abc4 ("rcu: Make SRCU mandatory")
is already in Linus' tree, i.e. bundling this in a single patch was unnecessary work
for you.

Anyways, since there isn't an external dependency, this can go through the KVM
tree.  Unless you prefer to take it directly, I'll make sure Paolo sends it along
at some point before v6.2 final.

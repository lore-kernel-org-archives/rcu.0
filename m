Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64328C388F9
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 23:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0544520BED
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 23:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hsm3UY6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKSXDH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Nov 2020 18:03:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgKSXDH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Nov 2020 18:03:07 -0500
Received: from localhost (unknown [176.167.53.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ADD720888;
        Thu, 19 Nov 2020 23:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605826986;
        bh=+6DWK5z08RlQsTh6L5K3Xb6lSM/W5SwfGRKzXvdKChg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hsm3UY6igDxMT2tXNVGYYq8Xqq6LBh3a974KojgYbJRihsRIagv4er7slMQoCmbvy
         zY0N0iFsv6qbefD9KeHKYQW5fSQslNIeEMOirRFPxti+SDnTmTfccgYsPhkOrzkvMn
         dPtdf7DgFCjwpR+TEWgqnXxXH6UogvjmXRg2eT7Y=
Date:   Fri, 20 Nov 2020 00:03:03 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] tools/rcutorture: Make identify_qemu_vcpus() independant
 of local language
Message-ID: <20201119230303.GA31371@lothringen>
References: <20201119003024.10701-1-frederic@kernel.org>
 <20201119215903.GD1437@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201119215903.GD1437@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 19, 2020 at 01:59:03PM -0800, Paul E. McKenney wrote:
> On Thu, Nov 19, 2020 at 01:30:24AM +0100, Frederic Weisbecker wrote:
> > The implementation expects `lscpu` to have a "CPU: " line, for example:
> > 
> > 	CPU(s):		8
> > 
> > But some local language settings may advocate for their own version:
> > 
> > 	Processeur(s) :		8
> > 
> > As a result the function may return an empty string and rcutorture would
> > dump the following warning (still with the local taste):
> > 
> > 	kvm-test-1-run.sh: ligne 138 : test:  : nombre entier attendu comme expression
> > 
> > Just use a command whose output every language agree with.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: rcu@vger.kernel.org
> 
> Queued for review and testing, thank you!  As usual, I could not resist
> the urge to edit a bit, so please let me know if I messed anything up.
> 
> If there are too many of these, it might be easier for kvm.sh to switch
> itself to EN-US mode, but this change both simplified the code and helped
> defend the purity of the French language, so steady as she goes!  ;-)

We aligned the stars!

> commit 655f941b96cbfc6f8869142ece092d8617425948
> Author: Frederic Weisbecker <frederic@kernel.org>
> Date:   Thu Nov 19 01:30:24 2020 +0100
> 
>     tools/rcutorture: Make identify_qemu_vcpus() independent of local language
>     
>     The rcutorture scripts' identify_qemu_vcpus() function expects `lscpu`
>     to have a "CPU: " line, for example:
>     
>             CPU(s):         8
>     
>     But different local language settings can give different results:
>     
>             Processeur(s) :         8
>     
>     As a result, identify_qemu_vcpus() may return an empty string, resulting
>     in the following warning (with the same local language settings):
>     
>             kvm-test-1-run.sh: ligne 138 : test:  : nombre entier attendu comme expression
>     
>     This commit therefore changes identify_qemu_vcpus() to use getconf,
>     which produces local-language-independend output.
>     
>     Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>     Cc: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Josh Triplett <josh@joshtriplett.org>
>     Cc: Steven Rostedt <rostedt@goodmis.org>
>     Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>     Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>     Cc: rcu@vger.kernel.org

Even better, Thanks!

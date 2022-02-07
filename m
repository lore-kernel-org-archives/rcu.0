Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AE0C433F5
	for <rcu@archiver.kernel.org>; Mon,  7 Feb 2022 18:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbiBGSDs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Feb 2022 13:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345962AbiBGR6B (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Feb 2022 12:58:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F87C0401DA
        for <rcu@vger.kernel.org>; Mon,  7 Feb 2022 09:58:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AC81B8165D
        for <rcu@vger.kernel.org>; Mon,  7 Feb 2022 17:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E8AC004E1;
        Mon,  7 Feb 2022 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644256678;
        bh=Af7vNCJqPbi+5PT+nS8ivHQczXOnEjj97tRVGy4TrdA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gF83yQX+lXspiiF1I3dJQ4gHbWV9wPPR7PC35k5j/HEe+hE+6zcFwdUnHMff3Lmm1
         Acums+kU00Qmy0E464eYjGcglfaxY0s/ja7pAYke2fZAGJbPX8w8kgkieW47l/RUF0
         K2P7bCAQUaMTJ0EhUrRWy6qDcSduxiEqnh6TV7HcQ9746NlZ7SF82/rOl3aSn8QSby
         GwD0A72W5ZOuNarN4etAg2FSyOFOZbiDsx2oNaim2xZELGhHe10hVgwPA9kr5rP0Dc
         AYoDUP8XyCOyKypDRbAR0gO/xH4RYKINh79pWd31YpRPCsDJxqXVTT78sURgqYduwo
         gzqyPBiik7d6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0539E5C04EC; Mon,  7 Feb 2022 09:57:58 -0800 (PST)
Date:   Mon, 7 Feb 2022 09:57:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: ppc64le: rcutorture warns about improperly set
 `CONFIG_HYPERVISOR_GUEST` and `CONFIG_PARAVIRT`
Message-ID: <20220207175757.GE4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <36ffe02f-b299-2085-108a-5a4551e620fb@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36ffe02f-b299-2085-108a-5a4551e620fb@molgen.mpg.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 07, 2022 at 05:53:05PM +0100, Paul Menzel wrote:
> Dear Sebastian, dear Paul,
> 
> 
> In commit a6fda6dab9 (rcutorture: Tweak kvm options)
> `tools/testing/selftests/rcutorture/configs/rcu/CFcommon` was extended by
> the three selections below:
> 
>     CONFIG_HYPERVISOR_GUEST=y
>     CONFIG_PARAVIRT=y
>     CONFIG_KVM_GUEST=y
> 
> Unfortunately, `CONFIG_HYPERVISOR_GUEST` is x86 specific and
> `CONFIG_PARAVIRT` only available on x86 and ARM.
> 
> Thus, running the tests on a ppc64le system (POWER8 IBM S822LC), the script
> shows the warnings below:
> 
>     :CONFIG_HYPERVISOR_GUEST=y: improperly set
>     :CONFIG_PARAVIRT=y: improperly set
> 
> Do you have a way, how to work around that?

If you can tell me the Kconfig-option incantation for ppc64le, my thought
would be to make rcutorture look for a CFcommon.ppc64.  Then the proper
Kconfig options for each architecture could be supplied.

While we are thinking about this, here is the bash function that
figures out which architecture rcutorture is running on, which
is passed the newly built vmlinux file:

identify_qemu () {
	local u="`file "$1"`"
	if test -n "$TORTURE_QEMU_CMD"
	then
		echo $TORTURE_QEMU_CMD
	elif echo $u | grep -q x86-64
	then
		echo qemu-system-x86_64
	elif echo $u | grep -q "Intel 80386"
	then
		echo qemu-system-i386
	elif echo $u | grep -q aarch64
	then
		echo qemu-system-aarch64
	elif uname -a | grep -q ppc64
	then
		echo qemu-system-ppc64
	else
		echo Cannot figure out what qemu command to use! 1>&2
		echo file $1 output: $u
		# Usually this will be one of /usr/bin/qemu-system-*
		# Use TORTURE_QEMU_CMD environment variable or appropriate
		# argument to top-level script.
		exit 1
	fi
}

First, any better approach?

Second, we need to know the Kconfig options -before- the vmlinux
file is generated.  What is the best approach in that case?

							Thanx, Paul

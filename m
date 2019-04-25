Return-Path: <SRS0=0EAO=S3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19382C43219
	for <rcu@archiver.kernel.org>; Thu, 25 Apr 2019 17:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA3C20717
	for <rcu@archiver.kernel.org>; Thu, 25 Apr 2019 17:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfDYRNI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:13:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59920 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDYRNI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Apr 2019 13:13:08 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hJhvj-0004RU-Jv; Thu, 25 Apr 2019 19:13:03 +0200
Date:   Thu, 25 Apr 2019 19:13:03 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kselftest@vger.kernel.org, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] rcutorture: Tweak kvm options
Message-ID: <20190425171303.eofzt4hjp2445yon@linutronix.de>
References: <20190424073446.8577-1-bigeasy@linutronix.de>
 <20190425164558.GA233442@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190425164558.GA233442@google.com>
User-Agent: NeoMutt/20180716
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2019-04-25 12:45:58 [-0400], Joel Fernandes wrote:
> On Wed, Apr 24, 2019 at 09:34:46AM +0200, Sebastian Andrzej Siewior wrote:
> > In one of my rcutorture tests the TSC clocksource got marked unstable
> > due to a large difference in the TSC value. I'm not sure if the guest
> > run for a long time with disabled interrupts or if the host was very
> > busy and didn't schedule the guest for some time.
> > I took a look on the qemu/KVM options and decided to update the options:
> > - Use kvm{32|64} as CPU. We could probably use `host' (like ARM does)
> >   for maximum available features but since we don't run any userland I'm
> >   not sure if it makes any difference.
> > 
> > - Drop the "noapic" option, enable TSC deadline timer. There is no
> >   history why the APIC was disabled, I see no reason for it. The
> >   deadline timer is probably "nicer".
> 
> I was wondering why the tsc deadline timer can't just be the default in the
> kernel if it is "nicer" / "better" , and why does it need to be an option.

The tsc-deadline=on part tells qemu to expose it. Otherwise the kernel
can't use HW that isn't there.
I added q35 as the machine which should pass enough sane default
options. If this tsc-deadline timer is a problem we could probably drop
it. The local-apic should work.

> > - I didn't add a random HW device. It would make the random device ready
> >   earlier (not it doesn't complete the initialisation at all) but I
> >   doubt that there is any need for this.
> 
> Didn't follow this point about "random HW device". It looks like there is no
> part of the patch that matches this comment. There was no "random HW device"
> needed for this change of the clocksource, so could you clarify what this means?

I wanted to "upgrade" the kvm options and as part of it also add:
         -object rng-random,filename=/dev/urandom,id=rng0
         -device virtio-rng-pci,rng=rng0

With that change you would see
|random: crng init done

during boot. Now you should end up with "only" 
|random: fast init done

I mentioned it because I didn't see a reason why to do so. If someone
has an idea why it would make sense for rcutorture to use it, I can add
it.

> Otherwise lgtm, thanks!
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> - Joel

Sebastian

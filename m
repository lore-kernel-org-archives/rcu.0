Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D4FEB64DA
	for <rcu@archiver.kernel.org>; Sun,  2 Jul 2023 14:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjGBOEZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 2 Jul 2023 10:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBOEX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 2 Jul 2023 10:04:23 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891D21A2;
        Sun,  2 Jul 2023 07:04:22 -0700 (PDT)
User-agent: mu4e 1.10.4; emacs 29.0.92
From:   Sam James <sam@gentoo.org>
To:     regressions@leemhuis.info
Cc:     Jason@zx2c4.com, andy@greyhouse.net, bagasdotme@gmail.com,
        boqun.feng@gmail.com, boris.ovstrosky@oracle.com, bp@alien8.de,
        dave.hansen@linux.intel.com, david@unsolicited.net,
        eric.devolder@oracle.com, hpa@zytor.com, j.vosburgh@gmail.com,
        joel@joelfernandes.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manuel.leiner@gmx.de, miguel.luis@oracle.com, mingo@redhat.com,
        netdev@vger.kernel.org, paulmck@kernel.org, rafael@kernel.org,
        rcu@vger.kernel.org, regressions@lists.linux.dev,
        tglx@linutronix.de, wireguard@lists.zx2c4.com, x86@kernel.org
Subject: Re: Fwd: RCU stalls with wireguard over bonding over igb on Linux
 6.3.0+
In-Reply-To: <10f2a5ee-91e2-1241-9e3b-932c493e61b6@leemhuis.info>
Date:   Sun, 02 Jul 2023 15:03:36 +0100
Message-ID: <87sfa6if4x.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

#regzbot link: https://bugs.gentoo.org/909066

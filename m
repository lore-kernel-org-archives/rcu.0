Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBB2C64EC4
	for <rcu@archiver.kernel.org>; Tue,  7 Mar 2023 03:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCGDcK convert rfc822-to-8bit (ORCPT
        <rfc822;rcu@archiver.kernel.org>); Mon, 6 Mar 2023 22:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCGDcG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 6 Mar 2023 22:32:06 -0500
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8635041086;
        Mon,  6 Mar 2023 19:32:01 -0800 (PST)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id C65B71C15C1;
        Tue,  7 Mar 2023 03:08:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 0ED7A80009;
        Tue,  7 Mar 2023 03:08:48 +0000 (UTC)
Message-ID: <753b72f5ecd03f94511495a333eb192c5fc42087.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Error out if deprecated RCU API used
From:   Joe Perches <joe@perches.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        Uladzislau Rezki <urezki@gmail.com>
Date:   Mon, 06 Mar 2023 19:08:48 -0800
In-Reply-To: <20230307030457.3499834-1-joel@joelfernandes.org>
References: <20230307030457.3499834-1-joel@joelfernandes.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 0ED7A80009
X-Stat-Signature: q6faunwchiczi37yesgxkkqg9tku56gw
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+e6Vqn+wwD9djcED9qPoIDVpMIQG1X9w0=
X-HE-Tag: 1678158528-144933
X-HE-Meta: U2FsdGVkX1+wEczoCzrqRpm71mFu2nEwyoVR+qz26aXkauCxDrRFIlRixuE/WuAb/P2lF0NYFTc984BDdItMng==
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 2023-03-07 at 03:04 +0000, Joel Fernandes (Google) wrote:
> Single-argument kvfree_rcu() usage is being deprecated [1] [2] as it is
> error-prone. However, till all users are converted, we would like to introduce
> checkpatch errors for new patches submitted.
> 
> This patch adds support for the same. Tested with a trial patch.
> 
> For now, we are only considering usages that don't have compound
> nesting, for example ignore: kvfree_rcu( (rcu_head_obj), rcu_head_name).
> This is sufficient as such usages are unlikely.
> 
> Once all users are converted and we remove the old API, we can also revert this
> checkpatch patch then.

I think this should be added to the deprecated_apis hash instead

our %deprecated_apis = (
	"synchronize_rcu_bh"			=> "synchronize_rcu",
	"synchronize_rcu_bh_expedited"		=> "synchronize_rcu_expedited",
	"call_rcu_bh"				=> "call_rcu",
	"rcu_barrier_bh"			=> "rcu_barrier",
	"synchronize_sched"			=> "synchronize_rcu",
	"synchronize_sched_expedited"		=> "synchronize_rcu_expedited",
	"call_rcu_sched"			=> "call_rcu",
	"rcu_barrier_sched"			=> "rcu_barrier",
	"get_state_synchronize_sched"		=> "get_state_synchronize_rcu",
	"cond_synchronize_sched"		=> "cond_synchronize_rcu",
	"kmap"					=> "kmap_local_page",
	"kunmap"				=> "kunmap_local",
	"kmap_atomic"				=> "kmap_local_page",
	"kunmap_atomic"				=> "kunmap_local",
);


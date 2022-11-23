Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E0DC433FE
	for <rcu@archiver.kernel.org>; Wed, 23 Nov 2022 22:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiKWWHB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Nov 2022 17:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiKWWGz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Nov 2022 17:06:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBC06587C;
        Wed, 23 Nov 2022 14:06:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 810BCCE27E9;
        Wed, 23 Nov 2022 22:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F05C433C1;
        Wed, 23 Nov 2022 22:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669241211;
        bh=/7dPPWDOLt3RfGahyD2/fSmkAD12JNWT03DPRG4zap4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itKRR4UbhhfOorTMdNKR6cKqlxN4HUuuVzot0BrOYtejLBZgcCrd+5LIwpAkhNdXf
         mvPMzskm7O8KzD/FH8iPcLtRIaO/p32DtxKZB4Gdd05TsQeMPSqy8O1DvuUQQhRYLj
         eChzJbzyHcIQe0367dBniMqar4w6MZRAECdAOmXu8ex6vDNCsKhFnEW472Tdn/uTH7
         xk8NKwT+Zph+OSWk9BLenI21qsEhjIQ14oxTGrQOe+PYhT9TWFq+2vITb8SfbvbuaV
         zF8PThTBtmsUI0brZfSR9O9r0BMYsryvFdcjJlZ842RehsPJGn95hF2KNDwOg3ZHxx
         pPzVO44R/q+VQ==
Date:   Wed, 23 Nov 2022 23:06:48 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, heng.su@intel.com,
        rcu@vger.kernel.org
Subject: Re: PID_NS unshare VS synchronize_rcu_tasks() (was: Re: [Syzkaller &
 bisect] There is task hung in "synchronize_rcu" in v6.1-rc5 kernel)
Message-ID: <20221123220648.GA1395324@lothringen>
References: <Y3sOgrOmMQqPMItu@xpf.sh.intel.com>
 <20221123143758.GA1387380@lothringen>
 <Y35ALpl8borkSHjy@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y35ALpl8borkSHjy@xpf.sh.intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 23, 2022 at 11:45:50PM +0800, Pengfei Xu wrote:
> On 2022-11-23 at 15:37:58 +0100, Frederic Weisbecker wrote:
> > I have no idea how to solve the situation without violating the pid_namespace
> > rules and unshare() semantics (although I wish unshare(CLONE_NEWPID) had a less
> > error prone behaviour with allowing creating more than one task belonging to the
> > same namespace).
> > 
> > So probably having an SRCU read side critical section within exit_notify() is
> > not a good idea, is there a solution to work around that for rcu tasks?
> > 
>   Thanks for the analysis!
>   Add one more information: I tried to revert this commit only on top of
>   v6.1-rc5 mainline by script, but it caused kernel make to fail, it could not
>   confirm the bisect information is 100% accurate if I could not pass the
>   revert step verification. I just provide all the information I could.

No problem, I managed to reproduce with latest upstream.
I don't think the bisected commit is the culprit though, it may perhaps just make
the issue more likely to happen.

Thanks.

> 
>   And this issue is too difficult to me.
>   If I find more clue, I will update the eamil.
> 
>   Thanks!
>   BR.
> 
> > Thanks.

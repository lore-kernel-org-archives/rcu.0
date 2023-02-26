Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ACFC7EE2D
	for <rcu@archiver.kernel.org>; Sun, 26 Feb 2023 19:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBZTpQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 26 Feb 2023 14:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZTpP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 26 Feb 2023 14:45:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9C61287A;
        Sun, 26 Feb 2023 11:45:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95B8EB80C8D;
        Sun, 26 Feb 2023 19:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DC1C433EF;
        Sun, 26 Feb 2023 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677440712;
        bh=OSwtZh3LVmcBE8L5v7Q9+ZP5zaBH8RmFfr6WYe81suE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nWLt8iPZi1F6Q6kRLiWNkjYEJoFkVMqsWrJHSh1zNZeLfyM3gkZ74ifkZ7f4MWpe0
         6fVydqDUa/UUaKkQCWnnJzlBNm2SiKINCup0TilEjxKDxfCwR8VNljNqBe+9o3fKGn
         VJJJEkGetXiABdKXw042fauR2pzWXZeCCpnPV2OFe16J72nx9c6VQxkNBZ2C7R/p0n
         85p8cwIAScEyXckthaTVqzXLMr7aLdBCkdzwuDx8c0yaLqy4u/yR6iSHXEhxf2nYYk
         AXLAyA/33pOdHHjrQGFq7MRQyhxzQa5SQF4xSdJgv8ULiALab86CcBSRaqdZfHMhvi
         IpJktS5fuATIA==
Date:   Sun, 26 Feb 2023 20:45:08 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Message-ID: <Y/u2xK8FHwKMsJNh@lothringen>
References: <20230225033421.3323164-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230225033421.3323164-1-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Feb 25, 2023 at 03:34:21AM +0000, Joel Fernandes (Google) wrote:
> On many systems, a great deal of boot happens after the kernel thinks the boot
> has completed. It is difficult to determine if the system has really booted
> from the kernel side.

Is this only about kernel booting? What makes it hard to determine if the
system has really booted?

Thanks.

Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F4CC433F5
	for <rcu@archiver.kernel.org>; Tue, 22 Mar 2022 13:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiCVNVg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Mar 2022 09:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiCVNVf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Mar 2022 09:21:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037D469CDA;
        Tue, 22 Mar 2022 06:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D02D1B81C94;
        Tue, 22 Mar 2022 13:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58B5C340EC;
        Tue, 22 Mar 2022 13:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647955204;
        bh=GEP1hA952KtJkcY3mrrjdwlTd5xU8O8M7KG/kyoH+p8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qr7pyXMuaUdXxZF0V13kF5lL33LBkzJ1/elTp31hNhcj6wY51NTdwGzMoSjolSujO
         p2RFS8ljwNC8oZPOw74TZ7rD8FqZJsXCz6SFEa908GOiGcCoDP2DWHfN9sgUxGRLFc
         RnSirtJem5EaZg4DgM8C6IA5tMrwiICWxFryfXWXefatQtf7jaYB4UU7BOQYMarCqR
         /XDHqvMf1xrLRKIVsf/u9tBcaqD+jj6Xz4l9Eovmva7h30fNoRHQMBu4ixze7TBS/l
         5XNUsBIUqok/jtNsY8cyvqkAmdaq74IEVpRviQ0vm5jVG+vqxuiJh4BaIsRId9jVsZ
         zX56FAhQJc1zQ==
Date:   Tue, 22 Mar 2022 14:20:01 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] rcu: Deoffload rdp if rcuop/rcuog kthreads spawn
 failed
Message-ID: <20220322132001.GA705324@lothringen>
References: <20220322131753.1680329-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322131753.1680329-1-qiang1.zhang@intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 22, 2022 at 09:17:51PM +0800, Zqiang wrote:
> When CONFIG_RCU_NOCB_CPU is enabled and 'rcu_nocbs' is set, the rcuop
> and rcuog kthreads is created. however the rcuop or rcuog kthreads
> creation may fail, if failed, deoffload the offloaded rdp.

Thanks! I'm queuing these. I might split things and reword a bit.
Also I'll put the second patch first, otherwise bisection will be
broken.

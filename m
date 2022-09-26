Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0B9C32771
	for <rcu@archiver.kernel.org>; Mon, 26 Sep 2022 20:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIZUgh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 26 Sep 2022 16:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIZUgg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 26 Sep 2022 16:36:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191086CD2F
        for <rcu@vger.kernel.org>; Mon, 26 Sep 2022 13:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3AB3B8111B
        for <rcu@vger.kernel.org>; Mon, 26 Sep 2022 20:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CD8C433C1;
        Mon, 26 Sep 2022 20:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664224592;
        bh=vxHY6HICSCA3fxY0ox3d3ttWhqDHH/jop/h+SyEmdr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WT8WsKmoFFkQRXD+nxWBdiB4rBbrkfaSaod23M37Ny0NEN3PFozW/4QzlmjLTjOTE
         lfXrVLgvr/DeKfKnHYiFwEnSb2RvTJzq32z3CkLubfRObDgQniQkwkckStLDkt7xOG
         mWqaVdBmSRjJ0br1KmHfmBSQ7oPDdPy3esir0AttpghTsdr1CoNS+sjYDqKoCD3/pI
         H7f4wrRvQfFhIvLORjD8r6JJdHlA1q9G4Oje9hdT4KVUyYoj0bNRXMcGuF6uDJAz1s
         tfSqMViQd+m/s3bWVqbGUSzdLsqR/+rJ06mdlvTeOzBHS2rXHArx6M0l/0MMry+Wuy
         H/ijL//9dURSw==
Date:   Mon, 26 Sep 2022 22:36:29 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Yipeng Zou <zouyipeng@huawei.com>
Cc:     rcu@vger.kernel.org, paulmck@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rafael.j.wysocki@intel.com,
        peterz@infradead.org
Subject: Re: [PATCH] rcu: remove rcu_is_idle_cpu
Message-ID: <20220926203629.GA183228@lothringen>
References: <20220926015827.227050-1-zouyipeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926015827.227050-1-zouyipeng@huawei.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 26, 2022 at 09:58:27AM +0800, Yipeng Zou wrote:
> The commit "x86/cpu: Avoid cpuinfo-induced IPIing of idle CPUs" introduce
> this function to identify the current CPU idle state.
> But after commit "x86/aperfmperf: Replace arch_freq_get_on_cpu()" we
> just use MAX_SAMPLE_AGE to do that, So there is no use of this function.
> 
> Fixes: f3eca381bd49 ("x86/aperfmperf: Replace arch_freq_get_on_cpu()")
> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

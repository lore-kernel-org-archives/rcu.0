Return-Path: <SRS0=ioRT=24=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8483C282DD
	for <rcu@archiver.kernel.org>; Tue,  7 Jan 2020 20:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8851B2077B
	for <rcu@archiver.kernel.org>; Tue,  7 Jan 2020 20:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LzfATNAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgAGUd5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:33:57 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42135 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728457AbgAGUd5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 7 Jan 2020 15:33:57 -0500
Received: by mail-qv1-f67.google.com with SMTP id dc14so449421qvb.9
        for <rcu@vger.kernel.org>; Tue, 07 Jan 2020 12:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3zhpjGKRs5oCN7gE0zJUv09fBYY5DJxxWR8yhyAhckI=;
        b=LzfATNAFVRCE8SAl1d6Ctk4/lJ3RQSwN2ruwf6LC27wA411ljbwylPEOr6fqE9gRJK
         /aW3Q/ojQqDrhd3inOEO0hHNcy6SAQJ1vTsbc9lFG5jVP3pvqSdDSaU8Pa5owAqvBU8B
         luGS4iid5TYnlqBU3ecv9aw61bsN9ZpBz3F+DDSVAdrPb4wNO92hWHqqoQxhrBdpv5Ph
         oPrKDojhIIATLeooNxbXC9kMnsP5qZA1e90aV/Tz4jgc5sIqaT9AIJXuDHRgZ+XbpjTv
         +nk4SnEi+FeRmci7r55ERdAASdZgPpAY02r9b46vZe0iLEDR3Xge2WCmwVarMRF8iPmL
         g1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3zhpjGKRs5oCN7gE0zJUv09fBYY5DJxxWR8yhyAhckI=;
        b=VGf6RXE09xTOJPY3dxYx1NZZLR3rFSp4kaeyMzEStRTJtwKI50CQGxEe4l3u8q8cBj
         LN8DDHVr+sE2jfl87p1VicCJOwbvl5N9nmZHH0SyEM6qJme2xhYlDqBElN3DdXDrtR/y
         kpCcXFQ/r1sagbEdQo1PjBMG3ZDokkwlICqLstszFJhm4iNv/HqN86nFTbN5U4Ne9Q5d
         Pm6DJe18lIeha51nuVtZDWDfnOzX8HaaBbr7qk9wxuNkq0PE6Jbgqqm8zAy8Yy+7RG/g
         1gc5n8Kk4fjZKBRyWRqjRJO8wAqpxK2reoD1upVpEnEIgo+fjewrG/RXSMDjZGK/mj6T
         GmaQ==
X-Gm-Message-State: APjAAAXtL63kCkVZGFlBE7OYExsxrKX0TqY1m9/854uiABRMFIxZoGKh
        5UQoT4iFWCftVXFSK884xiUijA==
X-Google-Smtp-Source: APXvYqzWbftKZEr84YWD8iGrR1oDz0h1VmVb/RITKJH7Bi68eIZnbK/lkG9EUM5l75oi0+8mHGJU/Q==
X-Received: by 2002:a05:6214:1150:: with SMTP id b16mr1181882qvt.71.1578429235967;
        Tue, 07 Jan 2020 12:33:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i28sm446729qtc.57.2020.01.07.12.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 12:33:55 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iovY2-0001Xd-Ue; Tue, 07 Jan 2020 16:33:54 -0400
Date:   Tue, 7 Jan 2020 16:33:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     madhuparnabhowmik04@gmail.com
Cc:     dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, paulmck@kernel.org, rcu@vger.kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] infiniband: hw: hfi1: verbs.c: Use built-in RCU list
 checking
Message-ID: <20200107203354.GD26174@ziepe.ca>
References: <20200107192912.22691-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107192912.22691-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 08, 2020 at 12:59:12AM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> list_for_each_entry_rcu has built-in RCU and lock checking.
> Pass cond argument to list_for_each_entry_rcu.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>  drivers/infiniband/hw/hfi1/verbs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
> index 089e201d7550..e6abdbcb4ffb 100644
> +++ b/drivers/infiniband/hw/hfi1/verbs.c
> @@ -515,7 +515,8 @@ static inline void hfi1_handle_packet(struct hfi1_packet *packet,
>  				       opa_get_lid(packet->dlid, 9B));
>  		if (!mcast)
>  			goto drop;
> -		list_for_each_entry_rcu(p, &mcast->qp_list, list) {
> +		list_for_each_entry_rcu(p, &mcast->qp_list, list,
> +					lock_is_held(&(ibp->rvp.lock).dep_map)) {

Why .dep_map? Does this compile?

Jason

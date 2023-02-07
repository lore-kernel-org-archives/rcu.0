Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1046C636CC
	for <rcu@archiver.kernel.org>; Tue,  7 Feb 2023 23:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBGXQr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 7 Feb 2023 18:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBGXQq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 7 Feb 2023 18:16:46 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A213ABA;
        Tue,  7 Feb 2023 15:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675811804; x=1707347804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r9/Q6Bj2iXWjFNbV1O/FqfjvchFdW2jywJbR7dZ6SU0=;
  b=F2iAwCf3bKC9e41OapGmxd6adEZD90o4q7mZdcbYRjuMIb1hzs6820r4
   cfkvfwfVhry7Ez4zUt0EvZxstumI6vepI3M0YfWJi9XkWY/51Ui55UmlO
   d74UU8P5LF9fM/5aVKlEz8YOyvPZEwPjyeyoueohez1lUdIz+iyCuidRi
   EeEykckpYM7RO7KsphA60DzBYyhnuc9O7evpr06X95PHvW7CDm34zkPpD
   XTPDwPXyi4xC9IeRtUpE71mCC7iER+lO5X6vakh2v3TBMhWg6fXDiQc7+
   EughdlRLGOuHdi1FG2gm9q3ALP4bFr2TuUhjlLZNl4j+RkloFjhJXYQzM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="329674342"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="329674342"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 15:16:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="660439779"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="660439779"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.209.12.59]) ([10.209.12.59])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 15:16:43 -0800
Message-ID: <ca89ed9f-3869-9556-0eb3-c5dc84511d95@linux.intel.com>
Date:   Tue, 7 Feb 2023 15:16:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 11/11] x86/smpboot: reuse timer calibration
To:     Usama Arif <usama.arif@bytedance.com>, dwmw2@infradead.org,
        tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com
References: <20230202215625.3248306-1-usama.arif@bytedance.com>
 <20230202215625.3248306-12-usama.arif@bytedance.com>
Content-Language: en-US
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <20230202215625.3248306-12-usama.arif@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2/2/2023 1:56 PM, Usama Arif wrote:
> From: Arjan van de Ven <arjan@linux.intel.com>
> 
> No point recalibrating for known-constant tsc.
> When tested on a 128 core, 2 socket server, this reduces
> the parallel smpboot time from 100ms to 30ms.
> 
> Not-signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

you can turn this in a Signed-off-By:



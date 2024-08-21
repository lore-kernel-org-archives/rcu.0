Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EB05672;
	Wed, 21 Aug 2024 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724202014; cv=none; b=HlHvBflw1UnMOfHjkhUDKzHDsiQ5Mmiz+bLdrPNbHBVJrMYvoEh2OnNteVwhydWTBpQA0OKvX5EctmZ1Xb1/Vc1MrS18XSGbzNt3y+xchLW1Cj88dCnqCUgyAP5NrFl4qKY9nx9dFb5JMjCzs9jST4omymQwZlVJEkIAhkyp6gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724202014; c=relaxed/simple;
	bh=BwnFs+ky9dP3dSEkc3Oxo2bJr4RqkZJE05LBXfWzL0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N8h3WaX+urx0IdL7y3oAXKNXflUzYO9y151aQn3nnpLUC8tJgfk/t7ZHzHN6yDzAj3pCrPqh1RmKfhbS3zOfy2Y/eXwNsPUhrcvj2XW/wTpCTcA9ZKK/QH1gKABBRwXxXWSPnHRELLs5L15JgXasmBOP4xu7nhPEsvSDDNjoiIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W8JaGEDw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W8JaGEDw"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBmjT011352;
	Wed, 21 Aug 2024 01:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZhOeF01KrVEz6V+Vra3QRgsNEqktXvI30DN9G5l2idQ=; b=W8JaGEDwOO1TfQlf
	e4XOC3VLjlT5yRv3d9ppvqfCd4ZkrW74thjA/cEmc9nrqZiauD6zZtkuFCBoZH2c
	3Rx8QoSuK7rVjHAa06pfk5cA2Qhc0VTKlerfO0ULkwgLSMr3t9gFg7YVdRKlDtXp
	9cNPLxVGREhnYDgHSbbSsGNsNlQGkLJU3a+J5U/j6jvzllCwGdXYhqCJjf4ZpefJ
	XijaolbtV/G+G7ZHTI2sZDrmn3mhqDDWRfZAeowxYoI35hArL5g7R5Mzr06i4Xw/
	dv1igFm9qfhUo8Y+eXZE3d7ZSr8Jk2rVqn1CDsKDArNHE8AuCkBNMHq9eDDnKjaa
	SqI7Ag==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414j573a48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 01:00:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47L104H9032708
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 01:00:04 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 20 Aug
 2024 18:00:04 -0700
Message-ID: <ef1347e4-64e3-4068-89cb-cb6038972b9e@quicinc.com>
Date: Tue, 20 Aug 2024 18:00:04 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] darray: lift from bcachefs
To: Kent Overstreet <kent.overstreet@linux.dev>, <rcu@vger.kernel.org>
CC: <paulmck@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
 <20240819165939.745801-4-kent.overstreet@linux.dev>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240819165939.745801-4-kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1KUvgS38UYLGuCyQvOjnZwsRt1BEk888
X-Proofpoint-GUID: 1KUvgS38UYLGuCyQvOjnZwsRt1BEk888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_19,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210005

On 8/19/24 09:59, Kent Overstreet wrote:
> dynamic arrays - inspired from CCAN darrays, basically c++ stl vectors.
> 
> Used by thread_with_stdio, which is also being lifted from bcachefs for
> xfs.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  MAINTAINERS                             |  7 +++
>  fs/bcachefs/Makefile                    |  1 -
>  fs/bcachefs/btree_node_scan_types.h     |  2 +-
>  fs/bcachefs/btree_types.h               |  2 +-
>  fs/bcachefs/btree_update.c              |  2 +
>  fs/bcachefs/btree_write_buffer_types.h  |  2 +-
>  fs/bcachefs/disk_accounting_types.h     |  2 +-
>  fs/bcachefs/fsck.c                      |  2 +-
>  fs/bcachefs/journal_io.h                |  2 +-
>  fs/bcachefs/journal_sb.c                |  2 +-
>  fs/bcachefs/sb-downgrade.c              |  3 +-
>  fs/bcachefs/sb-errors_types.h           |  2 +-
>  fs/bcachefs/sb-members.h                |  2 +-
>  fs/bcachefs/subvolume.h                 |  1 -
>  fs/bcachefs/subvolume_types.h           |  2 +-
>  fs/bcachefs/thread_with_file_types.h    |  2 +-
>  fs/bcachefs/util.h                      | 29 +-----------
>  {fs/bcachefs => include/linux}/darray.h | 59 ++++++++++++++++---------
>  include/linux/darray_types.h            | 22 +++++++++
>  lib/Makefile                            |  2 +-
>  {fs/bcachefs => lib}/darray.c           | 12 ++++-
>  21 files changed, 96 insertions(+), 64 deletions(-)
>  rename {fs/bcachefs => include/linux}/darray.h (66%)
>  create mode 100644 include/linux/darray_types.h
>  rename {fs/bcachefs => lib}/darray.c (57%)

...

> diff --git a/fs/bcachefs/darray.c b/lib/darray.c
> similarity index 57%
> rename from fs/bcachefs/darray.c
> rename to lib/darray.c
> index b7d223f85873..b6868db7f956 100644
> --- a/fs/bcachefs/darray.c
> +++ b/lib/darray.c
> @@ -1,10 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) 2022-2024 Kent Overstreet <kent.overstreet@linux.dev>
> + */
>  
> +#include <linux/darray.h>
>  #include <linux/log2.h>
> +#include <linux/module.h>
>  #include <linux/slab.h>
> -#include "darray.h"
>  
> -int __bch2_darray_resize(darray_char *d, size_t element_size, size_t new_size, gfp_t gfp)
> +int __darray_resize_slowpath(darray_char *d, size_t element_size, size_t new_size, gfp_t gfp)
>  {
>  	if (new_size > d->size) {
>  		new_size = roundup_pow_of_two(new_size);
> @@ -23,3 +27,7 @@ int __bch2_darray_resize(darray_char *d, size_t element_size, size_t new_size, g
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(__darray_resize_slowpath);
> +
> +MODULE_AUTHOR("Kent Overstreet");
> +MODULE_LICENSE("GPL");

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1. Recently, multiple
developers, including myself, have been eradicating these warnings
treewide, and to prevent new instances from being introduced I scan lore
for patches which contain a MODULE_LICENSE but do not contain a
MODULE_DESCRIPTION(). This patch was flagged.

Normally I just ask that a MODULE_DESCRIPTION() be added. But in this
case I don't see how this can ever be built as a module since it is part
of an obj-y rule, and hence, unless I'm missing something, will always
be built-in. So in this case I would suggest removing the MODULE_AUTHOR
and MODULE_LICENSE.

However, if you do anticipate this could be built as a module in the
future, please just add the MODULE_DESCRIPTION().

/jeff



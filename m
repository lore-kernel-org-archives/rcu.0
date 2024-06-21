Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083881684B8;
	Fri, 21 Jun 2024 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718991112; cv=fail; b=iddbxrFOaSuOKS8KRbUaIMEQgyLRzQLrUrOfcAq/Qj9HfMx17JVbRS8+6Wx9QurAhhH1yeRHjFMZEZyXIl3a1el6BVk+0j3XJyui66kIhmoggSRVRxk1N4bw2VAon3A6LMuusTp5Pc+PPiWGan51WHgmJW3ulCMyHhBSNkNDNTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718991112; c=relaxed/simple;
	bh=62kSxkYNjdxkKUDyycTMUiH8llA9Bf4OPvRqgH8ZQi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WYPHDwssypVOPZ2wkqZF9MG8h4g3okiznD0NnZxtRbN/Jwm4B032geHdnQpzMZT2yy81h8pAbMcRdcVUHkvHoZQ7zmv+jcAgp73Gqk8jMqYBrEWHKEY7GMQsvgDUAXcE/UJ52ycOWb2en51cjsr90ZHoZyCBBMfeOwIDCxBEUjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b6M3VW0k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rHVNCfB2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b6M3VW0k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rHVNCfB2"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEXZvQ010397;
	Fri, 21 Jun 2024 17:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=i+pI1Rf345pmexQ
	AV3kVq4dskdXKQpzIwlZ7ekQOHI8=; b=b6M3VW0kT9FsNL4kJySc6osrcH8qsOz
	5fcVGhispyFl2FwJ9zVPmjSweUHVBxZoXGdknQT+w/ShdA5aiF/Sax1yYglqQDfR
	Mf7HqHtZ2FJcY9jgEGouHLjJfN2ls2LGeeejbuLRFmXyc+L++2KgJBZfuyPMLN7a
	ILtf83V0apg4Hjjy2O5x21p46qcJtaL9xmXQqQqWPtRU1w48iSUCkT2zvL7mEu8X
	kc/Y46Z7rSDOxp9av06pwQ/xcvnqIYzVGhXy65ODiXhc1zGfpYdAYxS3usOkys3J
	LLAHkSbxkiBT1Q5IJTmcrAt3T0EYq0R65oSsVqMQIgFS3jj2AmWxIFw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrktt8sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 17:31:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45LGOiXA039787;
	Fri, 21 Jun 2024 17:31:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn4m25y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 17:31:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAHQGtlRtc/cHu1lDNIIZSY3PdPNJE/w97loSvsgnkQXO4hY94RYBkUHL2ShRXRxsV5o0EkLGdyze4u1/B5zlguioSmK8MkHT+daXg0vYhj9h6HOuaizTXZ8DBZalr8j71sg9Cg0msEX2o8Oeu6huxA3CpmL3b7W5sxG57BeyxxmjJ/3KYqXjCF/kONiCWPtRO7fku55/tfqf3+3PfwhtrI5ONQ6McxXKn5DPlri2y0KMEi1iE1T7q8WkDTTf3v3VtPtV33v+TL/JmoiGFGYZWZb7Qu9mrhvR1Tbikcwm/lhoLVgrkSsbS2GIY7CBpNnevsbibVfszXn8e5FuJcZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+pI1Rf345pmexQAV3kVq4dskdXKQpzIwlZ7ekQOHI8=;
 b=frdza+2mstHysuhGZNUcBosmijI6mj1HEywKQJ1iEcXnv5UQK+ueLk6ZHpk3wBLJkuBFiRXkbjVSCOF7IIfRaF/fw3mIbfaZIkFNiRbx42tU4j9cgj1O/1rtLi3A7We/2xYyRHfDIiYwkBaPqZyGdE1rCmveNrR8JAekpZJge1p67thFlF9R90SkMVPfIPf8/sYSSW4pMEm3DOrbhtDeT8YsHd70ulEHMhbxGDHwAuFLCr9vAdU00VtcL4XXVUPFUrsGftnR/Kj+wiK5dQjhrp7FcqCjCV35IUGq7eukp01xzI5ZY8SrnT7dp3A+eFtD969ItDlHsTYOAAKJRh2JTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+pI1Rf345pmexQAV3kVq4dskdXKQpzIwlZ7ekQOHI8=;
 b=rHVNCfB2Rv4muYrGCMKbKr8T5y+xizTkLjQG1fAESPpGlu3uLNcszP5OHJJOpi36i+ezFb23PiJb4kdE1qzK4Z2EM2Jc4KHTG9rXSHIg+STaaWdpq2j+kNIFlwvF0jFVTeKL4EHtGeCYTu/ZRlSAwteIDhuc38AN74WGRthytAc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 17:31:17 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 17:31:17 +0000
Date: Fri, 21 Jun 2024 13:31:14 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Marco Elver <elver@google.com>
Cc: syzbot <syzbot+9bb7d0f2fdb4229b9d67@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lstoakes@gmail.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        RCU <rcu@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in mtree_range_walk /
 rcu_segcblist_enqueue (2)
Message-ID: <3sldogk6uc4vxas366obosrgz6jwd4sms7edvsayt6l47aoieu@n5a4lee2rjnc>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Marco Elver <elver@google.com>, syzbot <syzbot+9bb7d0f2fdb4229b9d67@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lstoakes@gmail.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	RCU <rcu@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>
References: <0000000000008d1e5a061b666b11@google.com>
 <CANpmjNORLNHsWamYPU=rS7ftjZndchiEYHXznUS_RyR1edvrCA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNORLNHsWamYPU=rS7ftjZndchiEYHXznUS_RyR1edvrCA@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB6519:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8b32bb-d585-4a28-dd0a-08dc9217f4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013|7416011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QqPMPGGX561IquvWIzvDGQWjokYSP3+81QwY+44gBwBICSw9Z9Il8nJ1NbbK?=
 =?us-ascii?Q?zEiOLQXSZluEGshE0ln4Nnyxdb4B3+zNzCTYRoz+lqDbic7X7nxjCecGp1QW?=
 =?us-ascii?Q?yFJTTxI/pFLpEixCMvPQWXCIH8oUylE7xoW8uL98UMSn6L2E/T8U+24mDY67?=
 =?us-ascii?Q?0svYjsIwJB1zbIEd5x/SbxcqGOlVC/uvwLZn9JTlBGKS3QeNHPbo8LKNQyRj?=
 =?us-ascii?Q?puYUz3bLWd4Vj+b3jrgjZJM07Fh6dpjkApghjXmKrUSFy4z6dRJgVUm3v2e3?=
 =?us-ascii?Q?T6Wv/EqmXoz5Y05UqEnJs2/xLHBPSkDwjZ4+NvjdldRn8CvObsGnDi8wvnTC?=
 =?us-ascii?Q?RZpKLNoyU4TeT/X87/Y57H3q6yASwZU8vopFVXXN4+qxVtpW2uO0HXEXBrmc?=
 =?us-ascii?Q?q2Smy9GTTz3JWskYzu9XQ/ePt2Xvam6hLkvmE6NBlj25voBjIF4Db2Fzldqp?=
 =?us-ascii?Q?cTCDU1nlynJ6nLb2vd++dlzviX9S5HWS/rvnmAMELc0ZNtnCCWvho9frfD3D?=
 =?us-ascii?Q?xvz4+bFN2OsPpgI7wLmwF5RAMvPBzKjR3mfhd6W6bEH+nhjeJGqtGlnV8785?=
 =?us-ascii?Q?FrqBORS2L++wrq4foFtaiQaSGewNpyU86hQ7miTrkTR53RDJFVtK0TMolG+I?=
 =?us-ascii?Q?1G2qD2SImFLbJUbkF1qlc7S+A8BghKN886hsfuNXmTrGt2GrFqUkQxbV4Xn1?=
 =?us-ascii?Q?SOzANNciKbk5mCzcZX5cCtt2TWAJVAUo5GRawUtu6E7s24REb+pUvBET0kYc?=
 =?us-ascii?Q?lK7sfESSN/+wd5elBWOBdqpx1gdYLNKFZ8gVLoEBLIW9UcIWMCMi2Tdw8o2j?=
 =?us-ascii?Q?iESn+5Xo1qksZE8K8NYT83vgb0pEykC5NL6aBnRCcBYigQYEzgywyrEefLxl?=
 =?us-ascii?Q?SAk0oVm3zJ3d169jJP4i8RqHyD55us8aBdjzXS4uzB7JEFseiOJ2vRloRjSB?=
 =?us-ascii?Q?TeIy4WvboFU5X3oVzCLBCSgbttjOfXazvmQTtpqUQnx2DHBzBVhmnjNTJ1Zk?=
 =?us-ascii?Q?HaBF1FpBsbvHQOhHGY/QuD2nOlZ8Jvi1Yc3dB8naP6uKscLdcj5kflaRmdSg?=
 =?us-ascii?Q?bC3N5T7XLvwh3ZIALCywNC80AP88zII3r5cK6df/3+9aNVCit4ZzO/BpUNFG?=
 =?us-ascii?Q?0niGCWZL7W5ada6eLxQqbIjqHu731XrH2TKtOBVsgog3LiXHlonw10Fu6rId?=
 =?us-ascii?Q?9d5+v4SOMSL5LghE9rljXAkQRFEkfFbUnkMLFhlBVsUtMi3N4eOfkKuWSxxS?=
 =?us-ascii?Q?r29mzwrwpQ6KT00ne5Fj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(7416011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gEZI/lU+OaMHsngn2RcncognOcv6itOUco9nhia0gr4id1xBjN1ha+qVuGS8?=
 =?us-ascii?Q?YGxg5/aLqKOIhILxc8yYoii2LPI66YpxlyIbtxS7f7iLdS43Z7Wr1L++Hrei?=
 =?us-ascii?Q?YC3QkoxiWUefOMxCARVu4aOyLLEJFIPLkk5+dA1UVQiG1HP4+0iJM3Dpk+GA?=
 =?us-ascii?Q?WXvUsmwkKXT+cRlhs93cLY3unpTZVTg0bgcVowvEZW0aDsF9U+bMmcNCPwdM?=
 =?us-ascii?Q?r772t3Ytk3JAIcCgTTsCw4R7IbNbUZSYeGnnUU7Nx4eIlti5Ur2PgOG76ahK?=
 =?us-ascii?Q?JbjE/Uh6HLhCsLfYoAN5o1IGcXwISvBL6wCbQPEycxaAQWz5zt7agHSpBRCx?=
 =?us-ascii?Q?qT387Ft69Pz0RaprylupXTMOKhvzfohXUkvXgNyNsctQrxeCoRgsN9/kD/e1?=
 =?us-ascii?Q?ixgMCAIvyEzHxiz44/5WceiuBTJdNJSq5PyYPZ4I+nVyZZMs7WD5L2srvFeD?=
 =?us-ascii?Q?WFpE4WQUPtVSBEEuEpKQNjedDtjE7A5W3j0XNxUGCwdlFNikblGrRQZupllj?=
 =?us-ascii?Q?14TwXPveUQdf8sW6oztD4DOfJPr15EPaWaW5l+JYYQC7PUC8RqG4nSf6G1Ks?=
 =?us-ascii?Q?h7xeaXWMjB/ILtjwvHmQkw5e5/AcEaZxHS3uttWBXUZ6/kwCMynlpbvAB/Cn?=
 =?us-ascii?Q?vgnF7UuiBoq/ZmmteuZEdHBlWdDzKHJkZXlp829/1T97ryhXLhqdPOHBUf8Y?=
 =?us-ascii?Q?N2QV6n/g6lkXuQqCNpjF4lZmSg6Gc9cdA2Uwp2dvrRfYRwXX7ktQKLJphxui?=
 =?us-ascii?Q?uenafSj2fxP6KaB2o6Wcjoxuy6LOAENbZI4FnaYM6t6iGEEwU1JSFRdRjS42?=
 =?us-ascii?Q?NNqQz8uYSOA2QTXm8Rbakid0R3xB2x/TOyEDDCkUT6kq4JXeWxKD66fbnLdy?=
 =?us-ascii?Q?HQY9HYmLrhXz6o5IPRWv10KehicGF5XVvC4CK62rTwbHVpcLvkD98iY3eK57?=
 =?us-ascii?Q?BxRPpVxXDFXWQeUMqcdb7hZwKVdc+IHRd2A0XOpSArPPwTLmSBySlUhg3dzf?=
 =?us-ascii?Q?4vUDFTYB544d+bhNqhQtX1mFizhY4vHAH9CNfECk10E1e5dqNXlYhFDtaaJg?=
 =?us-ascii?Q?fzP0J8IAIQgju1KAzENB40ngVnB0KPnqxO34Atx5uHI85E4Zd5jYPAALSBMN?=
 =?us-ascii?Q?Io5GS8A/GPRdgVTwhhCxQ99rTMAe29F9GLHmxUlzdRJyOkq28TCxjQW8wIUb?=
 =?us-ascii?Q?OZdefVMLlvx4Hhc1rSrABsMkMF668xs2UgYvSly5/7ygRflxYwD3Ai6sB3ZJ?=
 =?us-ascii?Q?DLwMT4jwmkvkNZvB5T7n2+DBgm6bhXeADK2T/Kc5RUG58dWRbh50d5DAAT1u?=
 =?us-ascii?Q?BntQOQ4Cy85XhhK9qCwDuz1t92mQVUBdFSAnXSi9ZqRLs2zyuNbJWEDDQMxC?=
 =?us-ascii?Q?hSGXGIK6rQw39eIWJ2nScM1rh9MNdMb2tYBNhjW5LZTcKO3Etj5/saSFwKmO?=
 =?us-ascii?Q?JX85KXcquaFAoeRtB4NDtWTTBhCOQJswKB4jRLdf902eOgnzHC8KEM3D1rRF?=
 =?us-ascii?Q?tIBteKjHM3uagKCaCb/KrKoAoRlU1Uhhr8vzvq21UaIrkLEAQyygZRIjnrf2?=
 =?us-ascii?Q?r2UUUk0vo4tOgSLXNBIcYCxrTfnOXh9y0lxpCrD3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sDCP1kRNjB//+JPkoL6bVGs70SxwG6wRh9EpPE8s9pZKMplsAyTlpKYvljuYZViLl6ybsIliW6JkskPvWwmbxkRbhUlgch5JhhBcCKwh+CBeRaPBRofQF+tXU4vhdaJxZ4lt7cQaQ8RxjMlEuDZwijnMqzS08pI171M9bNnIHnhO+obL5tz+XK/kaTaeRBK+4I602kVAOdAv+N4qQOacTBh+m6/qxNd1xNCBtsFliegD64Ldz5jlXlqTm+2LTyiT0KYwZUmDLT1u/THVtx/q+j98QBoIvbphA2F98dvA12RDA3Pk3ogFPXGiK3R0819Foj9UXX1wgC6wfsqduzGNcrPz7yUgqo3TBm73hXpk36geCQUOzXKkSyLXLVWcjVcr6g7e6HT83Tg5HKJzjq1PKAlkttn8Mgv0kce5ziabQwjgKCGGAmxgzm06s6fHRgCt1bz8/61rmIWGXV4Xzds+YLHwgd17WC4vwSBhRFmKGUoatE4KbULAT8Ar7jrdwuVNjyO2LMCUcALqFFnGLizwhDLoTsT+6rIJ/8H5w8V63wWOJkE9kWgHe0PFdVzzb9CMGN7h6EN/AgaWhapuybAN67qTug2IFmXJDi2x8D15B5o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8b32bb-d585-4a28-dd0a-08dc9217f4fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 17:31:17.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkJzQAQjZlqsfBAG0wbP2lFP/yVlnc1/f9kYJTFdJBuQAZ+PBC6Fkqvh4QItS8nQmORorQ3o4r8ZeU1NRxvR6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_09,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210127
X-Proofpoint-GUID: YrtdUi5nHSzZpyiDCIlvvYhwxvtYqxd0
X-Proofpoint-ORIG-GUID: YrtdUi5nHSzZpyiDCIlvvYhwxvtYqxd0

* Marco Elver <elver@google.com> [240621 11:29]:
> [+Cc rcu folks]
> 
> On Fri, 21 Jun 2024 at 15:29, syzbot
> <syzbot+9bb7d0f2fdb4229b9d67@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    50736169ecc8 Merge tag 'for-6.10-rc4-tag' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=164ec02a980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=704451bc2941bcb0
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9bb7d0f2fdb4229b9d67
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/e4cbed12fec1/disk-50736169.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/d50b5dcae4cd/vmlinux-50736169.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/f2c14c5fcce2/bzImage-50736169.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+9bb7d0f2fdb4229b9d67@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in mtree_range_walk / rcu_segcblist_enqueue
> >
> > write to 0xffff888104077308 of 8 bytes by task 12265 on cpu 1:
> >  rcu_segcblist_enqueue+0x67/0xb0 kernel/rcu/rcu_segcblist.c:345
> >  rcutree_enqueue kernel/rcu/tree.c:2940 [inline]
> >  call_rcu_core kernel/rcu/tree.c:2957 [inline]
> >  __call_rcu_common kernel/rcu/tree.c:3093 [inline]
> >  call_rcu+0x1bd/0x430 kernel/rcu/tree.c:3176
> >  ma_free_rcu lib/maple_tree.c:197 [inline]
> >  mas_free lib/maple_tree.c:1304 [inline]
> >  mas_replace_node+0x2f8/0x440 lib/maple_tree.c:1741
> >  mas_wr_node_store lib/maple_tree.c:3956 [inline]
> >  mas_wr_modify+0x2bc3/0x3c90 lib/maple_tree.c:4189
> >  mas_wr_store_entry+0x250/0x390 lib/maple_tree.c:4229
> >  mas_store_prealloc+0x151/0x2b0 lib/maple_tree.c:5485
> >  vma_iter_store mm/internal.h:1398 [inline]
> >  vma_complete+0x3a7/0x760 mm/mmap.c:535
> >  __split_vma+0x623/0x690 mm/mmap.c:2440
> >  split_vma mm/mmap.c:2466 [inline]
> >  vma_modify+0x198/0x1f0 mm/mmap.c:2507
> >  vma_modify_flags include/linux/mm.h:3347 [inline]
> >  mprotect_fixup+0x335/0x610 mm/mprotect.c:637
> >  do_mprotect_pkey+0x673/0x9a0 mm/mprotect.c:820
> >  __do_sys_mprotect mm/mprotect.c:841 [inline]
> >  __se_sys_mprotect mm/mprotect.c:838 [inline]
> >  __x64_sys_mprotect+0x48/0x60 mm/mprotect.c:838
> >  x64_sys_call+0x26f5/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:11
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > read to 0xffff888104077308 of 8 bytes by task 12266 on cpu 0:
> >  mtree_range_walk+0x140/0x460 lib/maple_tree.c:2774
> >  mas_state_walk lib/maple_tree.c:3678 [inline]
> >  mas_walk+0x16e/0x320 lib/maple_tree.c:4909
> >  lock_vma_under_rcu+0x84/0x260 mm/memory.c:5840
> >  do_user_addr_fault arch/x86/mm/fault.c:1329 [inline]
> >  handle_page_fault arch/x86/mm/fault.c:1481 [inline]
> >  exc_page_fault+0x150/0x650 arch/x86/mm/fault.c:1539
> >  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 PID: 12266 Comm: syz-executor.3 Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> > ==================================================================
> 
> This is not an ordinary data race. I suspect this to be an incorrect
> use of RCU, resulting in some kind of use-after-free / type-confusion.
> 
> The access within rcu_segcblist_enqueue() is to maple_node::rcu (at
> offset 8 into maple_node). The racing access in mtree_range_walk() is
> to either maple_node::mr64::pivot[0] or maple_node::ma64::pivot[0]
> (both also offset 8 into maple_node).

Since it's not freed and the reader holds the RCU read lock, there is no
use-after-free risk here.

Both are at offset 8 of the node, but there is no type confusion.

This is a false positive, which I can explain.

The reader at mtree_range_walk() at 2774 reads piv[0] at offset 8, but
will validate the information by checking the parent pointer at offset 0
prior to using the value.  In this case the check is on line 2793: if
(unlikely(ma_dead_node(node)))...

In the case of the reader having stale data, the data is thrown away and
the walk is started again.  This node is already taken out of the tree
and will not be encountered again.

Note that all types have the same parent pointer (of undefined type
struct maple_pnode *, to catch type confusion at compile time) at offset
0.

On the writer side, the struct maple_pnode *parent is set to the address
of the node itself.  When this happens,
lib/maple_tree.c:mte_set_node_dead() is called to set the parent parent
pointer and smp_wmb();  This corresponds to ma_dead_node() or
mte_dead_node() that uses smp_rmb(); prior to reading the parent
pointer.

I ran though this all with Paul (embarrassingly, a while back), and I
believe (if my notes are correct..) the fix I need here is to use
rcu_assign_pointer() in mte_set_node_dead() to make the checks here
happy.

Thanks,
Liam

